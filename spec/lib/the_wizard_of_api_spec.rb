require 'rack'
require 'rack/test'

require 'the_wizard_of_api'

describe TheWizardOfApi do
  include Rack::Test::Methods

  def app
    TheWizardOfApi.new
  end

  context "Throne Room" do
    subject { get "/throne" }

    it { should be_ok }
  end

  context "api mount point" do
    # default
    let(:api_mount_point) { "/api" }

    context "GET" do
      subject { get api_mount_point }

      it { should be_ok }
    end
  end
end
