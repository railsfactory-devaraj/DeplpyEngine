class DeployWorker
	include Sidekiq::Worker

	def perform(ip, app_name, task)
		application_name = app_name[app_name.keys[0]]
		@deploy_job = DeployJob.new
		# pipe_cmd_in, pipe_cmd_out = IO.pipe
		pid = Process.spawn("bundle exec cap HOSTS=#{ip} APP_NAME=#{app_name.keys[0]} DEPLOY_TO=#{application_name['deploy_to']} REPO_URL=#{application_name['repo_url']} production #{task}")
		Process.wait(pid)
		@deploy_job.job_id = self.jid
		if $?.exitstatus == 0
			@deploy_job.status = "Success"
		else
			@deploy_job.status = "Failure"
		end
		# @deploy_job.message = pipe_cmd_in.read
		# pipe_cmd_in.close
		@deploy_job.save
	end

end
