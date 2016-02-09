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

ActiveRecord::Schema.define(version: 20160209124823) do

  create_table "categories", force: true do |t|
    t.integer  "track_id"
    t.string   "show_name"
    t.integer  "min_units"
    t.integer  "min_courses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["track_id"], name: "index_categories_on_track_id"

  create_table "courses", force: true do |t|
    t.string   "course_name"
    t.string   "general_req"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fulfillments", force: true do |t|
    t.integer  "requirement_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fulfillments", ["course_id"], name: "index_fulfillments_on_course_id"
  add_index "fulfillments", ["requirement_id"], name: "index_fulfillments_on_requirement_id"

  create_table "requirements", force: true do |t|
    t.integer  "category_id"
    t.integer  "course_id"
    t.integer  "num_courses"
    t.string   "criteria"
    t.integer  "priority"
    t.boolean  "repeatable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requirements", ["category_id"], name: "index_requirements_on_category_id"

  create_table "takens", force: true do |t|
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
