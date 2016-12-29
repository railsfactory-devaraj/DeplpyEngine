require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DeployementsHelper. For example:
#
# describe DeployementsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DeploymentsHelper, type: :helper do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "get deploy path" do
  	app_deploy_details = get_deploy_path '52.32.42.38','Blog1'
  	expect(app_deploy_details).not_to be_nil
  	expect(app_deploy_details.class).to eq Hash
  end

  it 'return No server found if server did not match' do
  	app_deploy_details = get_deploy_path '127.0.0.1','Blog1'
  	expect(app_deploy_details).to eq 'No server found with 127.0.0.1'
  end

  it 'return No app found if application did not match' do
  	app_deploy_details = get_deploy_path '52.32.42.38','Test'
  	expect(app_deploy_details).not_to be_nil
  	expect(app_deploy_details.class).to eq String
  	expect(app_deploy_details).to eq 'No app found with Test'
  end

  it 'get cap task' do
  	cap_details = get_task_details 'deploy'
  	expect(cap_details).not_to be_nil
  	expect(cap_details).to eq 'deploy'
  	cap_details = get_task_details 'migration'
  	expect(cap_details).to eq 'deploy:migrate'
  end

  it 'return nil if no tasks matches' do
  	cap_details = get_task_details 'check'
  	expect(cap_details).to be_nil
  end
end
