class DeploymentsController < ApplicationController
	include DeploymentsHelper
	skip_before_action :verify_authenticity_token

	def service
		if !params[:server].nil? && !params[:app_name].nil? && !params[:task].nil?
			server_ip, app_name, task = params[:server], params[:app_name], params[:task]
			app_details = get_deploy_path server_ip,app_name
			task_details = get_task_details task
			if app_details.class == Hash && !task_details.nil?
				job_id = DeployWorker.perform_async(server_ip, app_details, task_details)
				@render_message = {message: "Success", status:200,job_id: job_id}
			else
				if app_details.class != Hash
					@render_message = {message: "Failed to queue due to #{app_details}", status:422 }
				elsif task_details.nil?
					@render_message = {message: "Failed to queue due to invalid task", status:422 }
				end
			end
			render json: @render_message
		else
			render json: {message: "Failed to queue", status:422 }
		end
	end
end
