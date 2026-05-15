class AddUniqueIndexToJobHistoryTechStacks < ActiveRecord::Migration[8.0]
  def change
    remove_index :job_history_tech_stacks, :job_history_id
    add_index :job_history_tech_stacks, [ :job_history_id, :tech_stack_id ], unique: true
  end
end
