require "the_wizard_of_api/version"
require 'faye'

class DeferrableBody
  include EventMachine::Deferrable

  def call(body)
    body.each do |chunk|
      @body_callback.call(chunk)
    end
  end

  def each &blk
    @body_callback = blk
  end
end

module TheWizardOfApi
  ASYNC = [-1, {}, []].freeze

  def self.new(app = nil)
    wizard = Rack::Builder.new do

      self.class.class_eval do
        def stream_line(body, shown_key, env, http_key)
          value = env[http_key]

          if value
            line = ["#{shown_key}:",value].join(" ")
            puts line
            body.call [line+"\n"]
          else
            puts
            puts env.inspect
            puts
          end
        end
      end

      map "/throne" do
        map "/response" do
          run Proc.new { |env|
            client = env.fetch('faye.client')

            req = Rack::Request.new(env)

            client.publish('/wizard_response',req.params['response'])

            [200,{},[]]
          }
        end
        run Proc.new { |env|

          body = DeferrableBody.new

          client = env.fetch('faye.client')

          EventMachine::next_tick {
            env['async.callback'].call([200, {'Content-Type' => 'text/plain'}, body])
            body.call [" " * 1024]
          }

          EventMachine::add_timer(0.5) {
            body.call ["Throne Room\n"]
          }

          client.subscribe('/api') do |message|
            first_line = message.values_at("REQUEST_METHOD","REQUEST_PATH","HTTP_VERSION").join(" ")+"\n"

            puts first_line
            body.call [first_line]

            stream_line(body, "Accept", message, "HTTP_ACCEPT")
            stream_line(body, "Accept-Encoding", message, "HTTP_ACCEPT_ENCODING")
            stream_line(body, "User-Agent", message, "HTTP_USER_AGENT")
            stream_line(body, "Host", message, "HTTP_HOST")
          end
          ASYNC
        }
      end

      map "/api" do
        run Proc.new { |env|
          body = DeferrableBody.new

          client = env.fetch('faye.client')

          EventMachine::next_tick {
            env['async.callback'].call([200, {'Content-Type' => 'text/plain'}, body])
            body.call [" " * 1024]
          }

          client.publish('/api', env)

          callback = env['async.callback']

          client.subscribe('/wizard_response') do |message|
            body.call [message]
            body.succeed
          end

          ASYNC
        }
      end

      run app if app
    end.to_app

    Faye::RackAdapter.new wizard, mount: "/faye"
  end
end
