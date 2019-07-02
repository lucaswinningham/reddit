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

ActiveRecord::Schema.define(version: 20190529230411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activations_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.text "content"
    t.boolean "active"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "up_votes_count"
    t.integer "dn_votes_count"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["token"], name: "index_comments_on_token", unique: true
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "nonces", force: :cascade do |t|
    t.bigint "user_id"
    t.string "value"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nonces_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "title"
    t.string "url"
    t.text "body"
    t.boolean "active"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sub_id"
    t.bigint "user_id"
    t.integer "up_votes_count"
    t.integer "dn_votes_count"
    t.index ["sub_id"], name: "index_posts_on_sub_id"
    t.index ["token"], name: "index_posts_on_token", unique: true
    t.index ["url"], name: "index_posts_on_url", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "salts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_salts_on_user_id"
  end

  create_table "subs", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subs_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "voteable_type"
    t.bigint "voteable_id"
    t.boolean "direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["voteable_type", "voteable_id"], name: "index_votes_on_voteable_type_and_voteable_id"
  end

  add_foreign_key "activations", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "nonces", "users"
  add_foreign_key "posts", "subs"
  add_foreign_key "posts", "users"
  add_foreign_key "salts", "users"
  add_foreign_key "votes", "users"
end
