class RemoveCompletedFromRoadmapSteps < ActiveRecord::Migration[8.0]
  def change
    remove_column :roadmap_steps, :completed, :boolean
  end
end
