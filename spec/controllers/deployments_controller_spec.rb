require 'rails_helper'

RSpec.describe DeploymentsController, type: :controller do

	it "check the responce" do
		post :service, :server => '52.32.42.38', :app_name => 'Blog1', :task => 'deploy'
		response_body = JSON.parse response.body
		expect(response_body['job_id']).not_to  be_nil
		expect(response_body['message']).to eq 'Success'
		expect(response_body['status']).to eq 200
	end

	it "check server_ip in request" do
		post :service
		response_body = JSON.parse response.body
		expect(response_body['job_id']).to  be_nil
		expect(response_body['status']).to  eq 422
	end

	it 'return invalid message if server did not match' do
		post :service, :server => '127.0.0.1', :app_name => 'Blog1', :task => 'deploy'
		response_body = JSON.parse response.body
		expect(response_body['job_id']).to  be_nil
		expect(response_body['message']).to eq 'Failed to queue due to No server found with 127.0.0.1'
		expect(response_body['status']).to eq 422
	end

	it 'return invalid message if application did not match' do
		post :service, :server => '52.32.42.38', :app_name => 'Test', :task => 'deploy'
		response_body = JSON.parse response.body
		expect(response_body['job_id']).to  be_nil
		expect(response_body['message']).to eq 'Failed to queue due to No app found with Test'
		expect(response_body['status']).to eq 422
	end

	it 'return invalid message if task invalid' do
		post :service, :server => '52.32.42.38', :app_name => 'Blog1', :task => 'check'
		response_body = JSON.parse response.body
		expect(response_body['job_id']).to  be_nil
		expect(response_body['message']).to eq 'Failed to queue due to invalid task'
		expect(response_body['status']).to eq 422
	end
end
