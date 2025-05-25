# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_25_140702) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "focus_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "roadmap_step_id", null: false
    t.integer "duration"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roadmap_step_id"], name: "index_focus_sessions_on_roadmap_step_id"
    t.index ["user_id"], name: "index_focus_sessions_on_user_id"
  end

  create_table "roadmap_steps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "resource_link"
    t.integer "position"
    t.bigint "dependency_step_id"
    t.bigint "roadmap_id", null: false
    t.index ["dependency_step_id"], name: "index_roadmap_steps_on_dependency_step_id"
    t.index ["roadmap_id"], name: "index_roadmap_steps_on_roadmap_id"
  end

  create_table "roadmaps", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "public", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roadmaps_on_user_id"
  end

  create_table "step_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "roadmap_step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roadmap_step_id"], name: "index_step_completions_on_roadmap_step_id"
    t.index ["user_id", "roadmap_step_id"], name: "index_step_completions_on_user_id_and_roadmap_step_id", unique: true
    t.index ["user_id"], name: "index_step_completions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "xp", default: 0
    t.integer "level", default: 1
    t.integer "current_streak", default: 0
    t.date "last_active_on"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "focus_sessions", "roadmap_steps"
  add_foreign_key "focus_sessions", "users"
  add_foreign_key "roadmap_steps", "roadmap_steps", column: "dependency_step_id"
  add_foreign_key "roadmap_steps", "roadmaps"
  add_foreign_key "roadmaps", "users"
  add_foreign_key "step_completions", "roadmap_steps"
  add_foreign_key "step_completions", "users"
end
