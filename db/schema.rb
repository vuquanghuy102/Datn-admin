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

ActiveRecord::Schema.define(version: 2020_05_25_155354) do

  create_table "courses", force: :cascade do |t|
    t.string "course_code"
    t.integer "max_slot", precision: 38
    t.integer "status", precision: 38
    t.integer "current_slot", precision: 38
    t.integer "subject_id", precision: 38
    t.index ["subject_id"], name: "index_courses_on_subject_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "role_id", precision: 38, null: false
    t.integer "authorization_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id", "authorization_id"], name: "index_permissions_on_role_id_and_authorization_id", unique: true
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string "week_value"
    t.string "week_day_value"
    t.string "period_value"
    t.string "location"
    t.integer "course_id", precision: 38
    t.index ["course_id"], name: "index_schedules_on_course_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "student_code"
    t.string "name"
    t.string "dob"
    t.string "class_name"
    t.string "program"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_code"
    t.string "subject_name"
    t.string "subject_type"
    t.string "credit_value"
    t.string "jhi_desc"
    t.string "department"
    t.integer "status", precision: 38
    t.integer "credit_value_number", precision: 38
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", precision: 38
    t.integer "role_id", precision: 38
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end