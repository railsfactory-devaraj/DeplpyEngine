class CreateDeployJobs < ActiveRecord::Migration
  def change
    create_table :deploy_jobs do |t|
      t.string :job_id
      t.string :status
      t.text :message
      t.string :parameters

      t.timestamps null: false
    end
  end
end
