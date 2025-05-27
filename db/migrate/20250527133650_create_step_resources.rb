class CreateStepResources < ActiveRecord::Migration[8.0]
  def change
    create_table :step_resources do |t|
      t.references :roadmap_step, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
