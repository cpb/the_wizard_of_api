require 'rack'
require 'rack/test'

require 'the_wizard_of_api'

describe TheWizardOfApi do
  context "Throne Room" do
    include Rack::Test::Methods

    def app
      TheWizardOfApi.new
    end

    subject { get "/throne" }

    it { should be_ok }
  end
end
