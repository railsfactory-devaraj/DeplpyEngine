require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe DeployWorker, type: :worker do
				include ActiveJob::TestHelper

  it "is in default queue" do
  	expect(DeployWorker).to be_processed_in :default
  end

  it "queue the job" do
  	DeployWorker.perform_async '127.0.0.1'
    expect(DeployWorker).to have(1).jobs
  	DeployWorker.perform_async '127.0.0.1'
    expect(DeployWorker).to have(2).jobs
  end

  it 'executes perform' do
    perform_enqueued_jobs do
      DeployWorker.perform_async '127.0.0.1'
    	allow(Process).to receive(:spawn).with('bundle exec cap HOSTS=127.0.0.1 production deploy')
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end