module DeploymentsHelper
	def get_deploy_path ip,app
		config = YAML.load_file("#{Rails.root}/config/appication_list.yml")
		if config[ip].nil?
			return "No server found with #{ip}"
		end
		app_details = config[ip].find {|x| x[app]}
		if app_details.nil?
			return "No app found with #{app}"
		end
		return app_details
	end

	def get_task_details task
		capistrano_tasks =YAML.load_file("#{Rails.root}/config/capistrano_tasks.yml")
		capistrano_tasks[task]
	end
end
