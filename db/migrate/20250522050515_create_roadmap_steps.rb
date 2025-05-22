class CreateRoadmapSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :roadmap_steps do |t|
      t.timestamps
    end
  end
end
