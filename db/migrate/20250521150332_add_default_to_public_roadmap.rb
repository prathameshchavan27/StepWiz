class AddDefaultToPublicRoadmap < ActiveRecord::Migration[8.0]
  def change
    change_column_default :roadmaps, :public, true
  end
end
