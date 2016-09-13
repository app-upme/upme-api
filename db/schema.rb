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

ActiveRecord::Schema.define(version: 20160718203449) do

  create_table "coaches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.text     "tokens",                 limit: 65535
    t.string   "name"
    t.string   "avatar"
    t.index ["email"], name: "index_coaches_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_coaches_on_reset_password_token", unique: true, using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "coach_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["coach_id"], name: "index_groups_on_coach_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.integer  "age"
    t.string   "gender"
    t.datetime "started_training_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "vo2max_trainings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "training_date"
    t.float    "distance",      limit: 24
    t.float    "average_speed", limit: 24
    t.float    "result",        limit: 24
    t.string   "ranking"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_vo2max_trainings_on_user_id", using: :btree
  end

  add_foreign_key "groups", "coaches"
  add_foreign_key "vo2max_trainings", "users"
end
