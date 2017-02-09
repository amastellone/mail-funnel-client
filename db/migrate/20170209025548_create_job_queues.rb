class CreateJobQueues < ActiveRecord::Migration[5.0]
  def change
    create_table :job_queues do |t|

      t.timestamps
    end
  end
end
