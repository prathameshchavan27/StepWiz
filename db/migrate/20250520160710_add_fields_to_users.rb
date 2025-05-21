class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  # db/migrate/xxxx_add_fields_to_users.rb
  def change
    add_column :fields_users, :name, :string
    add_column :fields_users, :xp, :integer
    add_column :fields_users, :level, :integer
    add_column :fields_users, :current_streak, :integer
    add_column :fields_users, :last_active_on, :date
  end
end
