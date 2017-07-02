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

ActiveRecord::Schema.define(version: 20170702030147) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "coaches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "authentication_token"
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
    t.integer  "group_id"
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.integer  "age"
    t.string   "gender"
    t.datetime "started_training_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["group_id"], name: "index_users_on_group_id", using: :btree
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
  add_foreign_key "users", "groups"
  add_foreign_key "vo2max_trainings", "users"
end
