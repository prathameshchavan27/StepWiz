class CreateFocusSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :focus_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :roadmap_step, null: false, foreign_key: true
      t.integer :duration
      t.datetime :completed_at

      t.timestamps
    end
  end
end
