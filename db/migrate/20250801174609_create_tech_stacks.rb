class CreateTechStacks < ActiveRecord::Migration[8.0]
  def change
    create_table :tech_stacks do |t|
      t.string :icon
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
