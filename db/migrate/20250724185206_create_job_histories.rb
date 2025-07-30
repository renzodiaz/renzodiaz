class CreateJobHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :job_histories do |t|
      t.string :company_name
      t.string :website_url
      t.string :job_title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.boolean :is_current
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
