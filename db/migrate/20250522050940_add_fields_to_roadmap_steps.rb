class AddFieldsToRoadmapSteps < ActiveRecord::Migration[8.0]
  def change
    add_column :roadmap_steps, :title, :string
    add_column :roadmap_steps, :description, :text
    add_column :roadmap_steps, :resource_link, :string
    add_column :roadmap_steps, :position, :integer
    add_column :roadmap_steps, :dependency_step_id, :bigint

    add_reference :roadmap_steps, :roadmap, null: false, foreign_key: true

    add_index :roadmap_steps, :dependency_step_id
    add_foreign_key :roadmap_steps, :roadmap_steps, column: :dependency_step_id
  end
end
