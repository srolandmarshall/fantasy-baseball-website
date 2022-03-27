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

ActiveRecord::Schema[7.0].define(version: 2022_03_27_043856) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.integer "rank"
    t.string "name"
    t.string "position", default: [], array: true
    t.string "mlb_team"
    t.float "adp"
    t.float "avg_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.text "portrait_url"
    t.string "yahoo_player_id"
    t.string "yahoo_player_key"
    t.string "last_year_draft"
    t.integer "last_year_end_rank"
    t.integer "current_o_rank"
    t.string "status"
    t.integer "last_year_team_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "rules", force: :cascade do |t|
    t.integer "order"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer "order"
    t.string "name"
    t.string "owners"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "players_id"
    t.index ["players_id"], name: "index_teams_on_players_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "players", "teams"
  add_foreign_key "teams", "players", column: "players_id"
end
