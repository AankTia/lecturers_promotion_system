# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150501123030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessment_result_lines", force: true do |t|
    t.integer  "assessment_result_id",                                            null: false
    t.integer  "percentage_assessment_id",                                        null: false
    t.decimal  "value",                    precision: 20, scale: 4, default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessment_results", force: true do |t|
    t.string   "code",                                                   null: false
    t.integer  "lecturer_id",                                            null: false
    t.integer  "assessor_id",                                            null: false
    t.date     "start_date",                                             null: false
    t.date     "end_date",                                               null: false
    t.decimal  "weighting_value", precision: 20, scale: 4, default: 0.0, null: false
    t.decimal  "average_value",   precision: 20, scale: 4, default: 0.0, null: false
    t.string   "state",                                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assessment_results", ["assessor_id"], name: "index_assessment_results_on_assessor_id", using: :btree
  add_index "assessment_results", ["code"], name: "index_assessment_results_on_code", unique: true, using: :btree
  add_index "assessment_results", ["lecturer_id"], name: "index_assessment_results_on_lecturer_id", using: :btree

  create_table "assessors", force: true do |t|
    t.string   "registration_number_of_employees", null: false
    t.integer  "study_program_id",                 null: false
    t.integer  "rank_of_lecturer_id",              null: false
    t.string   "name",                             null: false
    t.string   "place_of_birth",                   null: false
    t.date     "date_of_birth",                    null: false
    t.string   "gender",                           null: false
    t.string   "marital_status",                   null: false
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "address_line4"
    t.string   "position",                         null: false
    t.string   "education",                        null: false
    t.date     "date_of_addmission",               null: false
    t.string   "contact_number"
    t.string   "state",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculties", force: true do |t|
    t.string   "code",        null: false
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecturers", force: true do |t|
    t.string   "registration_number_of_employees", null: false
    t.integer  "study_program_id",                 null: false
    t.integer  "rank_of_lecturer_id",              null: false
    t.string   "name",                             null: false
    t.string   "place_of_birth",                   null: false
    t.date     "date_of_birth",                    null: false
    t.string   "gender",                           null: false
    t.string   "marital_status",                   null: false
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "address_line4"
    t.string   "position",                         null: false
    t.string   "education",                        null: false
    t.date     "date_of_addmission",               null: false
    t.string   "contact_number"
    t.string   "state",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_of_ratings_execution_of_works", force: true do |t|
    t.string   "code",                 null: false
    t.integer  "assessor_id",          null: false
    t.integer  "assessment_result_id", null: false
    t.string   "objection"
    t.date     "objection_date"
    t.string   "response"
    t.date     "response_date"
    t.string   "decision"
    t.date     "decision_date"
    t.string   "state",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "percentage_assessments", force: true do |t|
    t.string   "code",                                               null: false
    t.string   "name",                                               null: false
    t.text     "description"
    t.decimal  "value",       precision: 20, scale: 4, default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periodic_preferments", force: true do |t|
    t.string   "code",                       null: false
    t.integer  "preferment_id",              null: false
    t.date     "periodic_preferment_date",   null: false
    t.string   "periodic_preferment_number", null: false
    t.string   "state",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferments", force: true do |t|
    t.string   "code",                                 null: false
    t.integer  "list_of_ratings_execution_of_work_id", null: false
    t.integer  "rank_of_lecturer_id",                  null: false
    t.integer  "current_rank_of_lecturer_id",          null: false
    t.integer  "year_work_period"
    t.integer  "month_work_period"
    t.integer  "day_work_period"
    t.string   "decision_letter_number",               null: false
    t.date     "submissions_preferment_date",          null: false
    t.date     "preferment_date",                      null: false
    t.string   "state",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferments", ["current_rank_of_lecturer_id"], name: "index_preferments_on_current_rank_of_lecturer_id", using: :btree
  add_index "preferments", ["list_of_ratings_execution_of_work_id"], name: "index_preferments_on_list_of_ratings_execution_of_work_id", using: :btree
  add_index "preferments", ["rank_of_lecturer_id"], name: "index_preferments_on_rank_of_lecturer_id", using: :btree

  create_table "rank_of_lecturers", force: true do |t|
    t.string   "code",                                                null: false
    t.string   "name",                                                null: false
    t.text     "description"
    t.string   "symbol",                                              null: false
    t.decimal  "basic_salary", precision: 20, scale: 4, default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "study_programs", force: true do |t|
    t.integer  "faculty_id",      null: false
    t.string   "code",            null: false
    t.string   "name",            null: false
    t.string   "education_level", null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "language"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
