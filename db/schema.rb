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

ActiveRecord::Schema.define(version: 2020_07_16_211347) do

  create_table "course", force: :cascade do |t|
    t.string "course_code"
    t.integer "max_slot", precision: 38
    t.integer "status", precision: 38
    t.integer "current_slot", precision: 38
    t.integer "subject_id", precision: 38
    t.index ["subject_id"], name: "index_course_on_subject_id"
  end

  create_table "fp_user", force: :cascade do |t|
    t.string "login"
    t.string "password_hash"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "image_url"
    t.integer "activated", precision: 38
    t.string "lang_key"
    t.string "activation_key"
    t.string "reset_key"
    t.string "created_by"
    t.datetime "created_date", precision: 6
    t.datetime "reset_date", precision: 6
    t.string "last_modified_by"
    t.datetime "last_modified_date", precision: 6
    t.integer "student_id", precision: 38
    t.index ["student_id"], name: "index_fp_user_on_student_id"
  end

  create_table "permission", force: :cascade do |t|
    t.integer "role_id", precision: 38, null: false
    t.integer "authorization_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id", "authorization_id"], name: "index_permission_on_role_id_and_authorization_id", unique: true
    t.index ["role_id"], name: "index_permission_on_role_id"
  end

  create_table "register", force: :cascade do |t|
    t.string "semester"
    t.string "status"
    t.integer "student_id", precision: 38
    t.integer "course_id", precision: 38
    t.index ["course_id"], name: "index_register_on_course_id"
    t.index ["student_id"], name: "index_register_on_student_id"
  end

  create_table "role", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedule", force: :cascade do |t|
    t.string "week_value"
    t.string "week_day_value"
    t.string "period_value"
    t.string "location"
    t.integer "course_id", precision: 38
    t.index ["course_id"], name: "index_schedule_on_course_id"
  end

  create_table "student", force: :cascade do |t|
    t.string "student_code"
    t.string "name"
    t.string "dob"
    t.string "class_name"
    t.string "program"
  end

  create_table "subject", force: :cascade do |t|
    t.string "subject_code"
    t.string "subject_name"
    t.string "subject_type"
    t.string "credit_value"
    t.string "jhi_desc"
    t.string "department"
    t.integer "status", precision: 38
    t.integer "credit_value_number", precision: 38
  end

  create_table "user", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.index ["email"], name: "index_user_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_on_reset_password_token", unique: true
  end

  create_table "user_role", force: :cascade do |t|
    t.integer "user_id", precision: 38
    t.integer "role_id", precision: 38
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_user_role_on_role_id"
    t.index ["user_id"], name: "index_user_role_on_user_id"
  end

end
