require 'rails_helper'

RSpec.describe "Deployments", type: :request do
  describe "Post /depolments" do
    it "call Deployments service from other API" do
      post deployments_path(:server => '52.32.42.38',:app_name => 'Blog1',:task => 'deploy')
      response_body = JSON.parse response.body
      expect(response_body['job_id']).not_to  be_nil
			expect(response_body['message']).to eq 'Success'
			expect(response_body['status']).to eq 200
    end

    it "call Deployments service from other API without serverIp" do
    	post deployments_path
    	response_body = JSON.parse response.body
      expect(response_body['job_id']).to  be_nil
			expect(response_body['message']).to eq 'Failed to queue'
			expect(response_body['status']).to eq 422
    end
  end
end
