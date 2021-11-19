# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_19_182522) do

  create_table "challenges", force: :cascade do |t|
    t.datetime "starting_time"
    t.string "ending_time"
    t.string "challenge_name"
    t.string "challenge_image"
    t.integer "removal_policy"
    t.integer "new_user_policy"
    t.integer "penalty_policy"
    t.integer "workout_perday_policy"
    t.integer "workout_criteria"
    t.text "prize_policy"
    t.string "challenge_handle"
    t.integer "number_of_teams"
    t.integer "challenge_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "challenge_id"
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "photoworkouts", force: :cascade do |t|
    t.text "caption"
    t.integer "challenge_id"
    t.integer "user_id"
    t.integer "likes_count"
    t.string "photo_locator"
    t.integer "calories"
    t.string "main_exercise"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "privileges", force: :cascade do |t|
    t.integer "challenge_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "team_picture"
    t.integer "challenge_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "is_premium"
    t.string "profile_picture"
    t.text "bio"
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
