require "the_wizard_of_api/version"
require 'faye'

module TheWizardOfApi
  def self.new(app = nil)
    wizard = Rack::Builder.new do

      map "/throne" do
        run Proc.new {|env| [200, {"Content-type" => "text/html"}, ["Throne Room"]]}
      end

      map "/api" do
        run Proc.new { |env|
          client = env.fetch('faye.client')

          client.publish('/api', env)

          callback = env['async.callback']

          client.subscribe('/wizard_response') do |message|
            callback.call(message)
          end
          [-1, {}, []]
        }
      end

      run app if app
    end.to_app

    Faye::RackAdapter.new wizard, mount: "/faye"
  end
end
