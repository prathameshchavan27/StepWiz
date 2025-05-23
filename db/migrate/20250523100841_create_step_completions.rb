class CreateStepCompletions < ActiveRecord::Migration[8.0]
  def change
    create_table :step_completions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :roadmap_step, null: false, foreign_key: true

      t.timestamps
    end
    add_index :step_completions, [:user_id, :roadmap_step_id], unique: true
  end

end
