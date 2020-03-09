# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_09_053020) do

  create_table "body_weights", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "diary_id", null: false
    t.integer "weight_record", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_body_weights_on_diary_id"
    t.index ["user_id"], name: "index_body_weights_on_user_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "remark"
    t.integer "activity_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "meal_records", force: :cascade do |t|
    t.integer "diary_id", null: false
    t.string "title", null: false
    t.text "body"
    t.string "meal_image_id", null: false
    t.integer "intake_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_meal_records_on_diary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "gender", null: false
    t.string "profile_image_id"
    t.date "birthday"
    t.text "introduction"
    t.integer "height"
    t.integer "goal_weight"
    t.boolean "is_deleted", default: false, null: false
    t.integer "public_status", default: 0, null: false
    t.integer "rank_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
