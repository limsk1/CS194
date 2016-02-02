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

ActiveRecord::Schema.define(version: 20160201214943) do

  create_table "courses", force: true do |t|
    t.string   "course_name"
    t.string   "general_req"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", id: false, force: true do |t|
    t.integer "course_id"
    t.integer "track_id"
    t.string  "criteria"
  end

  add_index "requirements", ["course_id"], name: "index_requirements_on_course_id"
  add_index "requirements", ["track_id"], name: "index_requirements_on_track_id"

  create_table "takens", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.string  "grade"
    t.integer "unit"
  end

  add_index "takens", ["course_id"], name: "index_takens_on_course_id"
  add_index "takens", ["user_id"], name: "index_takens_on_user_id"

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "salt"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
