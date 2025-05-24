class AddCompletedBooleanToRoadmapStep < ActiveRecord::Migration[8.0]
  def change
    add_column :roadmap_steps, :completed, :boolean, default: false
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
