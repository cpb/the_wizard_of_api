require "the_wizard_of_api/version"

module TheWizardOfApi
  def self.new(app = nil)
    Rack::Builder.new do
      map "/throne" do
        run Proc.new {|env| [200, {"Content-type" => "text/html"}, ["Throne Room"]]}
      end

      run app if app
    end.to_app
  end
end
