require 'rack'
require 'rack/test'

require 'the_wizard_of_api'

require 'pry'

describe TheWizardOfApi do
  include Rack::Test::Methods

  def app
    TheWizardOfApi.new
  end

  context "Throne Room" do
    subject { get "/throne" }

    it "should stream the response" do
      expect(subject.status).to eql(-1)
    end

    pending "this isn't the actual feature-value i'm looking for" do
      it "should stream Throne Room first" do
        expect(subject.body).to include("Throne Room")
      end
    end
  end

  context "api mount point" do
    # default
    let(:api_mount_point) { "/api" }

    context "GET" do
      subject { get api_mount_point }

      it "should stream the response" do
        expect(subject.status).to eql(-1)
      end
    end
  end
end
