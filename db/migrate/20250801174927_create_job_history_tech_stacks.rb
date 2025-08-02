class CreateJobHistoryTechStacks < ActiveRecord::Migration[8.0]
  def change
    create_table :job_history_tech_stacks do |t|
      t.references :job_history, null: false, foreign_key: true
      t.references :tech_stack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
