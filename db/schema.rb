# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100314031925) do

  create_table "addresses", :force => true do |t|
    t.string "zip"
    t.string "prefecture"
    t.string "ward"
    t.string "area"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resets", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.boolean  "used",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "question"
    t.string   "answer_hash"
    t.string   "answer_salt"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "last_name_kana"
    t.string   "first_name_kana"
    t.boolean  "male"
    t.string   "home_tel"
    t.string   "mob_tel"
    t.string   "mob_email"
    t.string   "pc_email"
    t.string   "building_room"
    t.date     "birth"
    t.string   "fax"
    t.string   "zip3"
    t.string   "zip4"
    t.string   "prefecture"
    t.string   "ward_area"
  end

end
