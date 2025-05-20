class AddDefaultValuesToFieldsUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :xp, 0
    change_column_default :users, :level, 1
    change_column_default :users, :current_streak, 0
  end
end
