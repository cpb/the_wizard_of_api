require "the_wizard_of_api/version"
require 'faye'
require 'rack/try_static'

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

      map "/throne" do
        map "/response" do
          run Proc.new { |env|
            client = env.fetch('faye.client')

            req = Rack::Request.new(env)

            client.publish('/wizard_response',req.params['response'])

            [200,{},[]]
          }
        end

        run Rack::TryStatic.new(app,{
          root: Pathname.new(__FILE__).dirname.dirname.join("public").to_s,
          urls: %w[/],
          try: ['.html', 'index.html', '/index.html']})
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
