require "rails_helper"

RSpec.describe DeploymentsController, type: :routing do
  describe "routing" do
  	it "routes to service" do
      expect(:post => "/deployments").to route_to(:controller => "deployments", :action => "service", :format => :json)
    end
  end
end