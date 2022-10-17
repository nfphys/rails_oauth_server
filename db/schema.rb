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

ActiveRecord::Schema.define(version: 2022_10_16_080045) do

  create_table "authorization_codes", force: :cascade do |t|
    t.string "code", null: false
    t.string "scope"
    t.string "redirect_uri", null: false
    t.string "state", null: false
    t.string "client_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_authorization_codes_on_client_id"
    t.index ["code"], name: "index_authorization_codes_on_code"
    t.index ["user_id"], name: "index_authorization_codes_on_user_id"
  end

  create_table "client_redirect_uris", force: :cascade do |t|
    t.string "uri", null: false
    t.string "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_client_redirect_uris_on_client_id"
  end

  create_table "clients", id: :string, force: :cascade do |t|
    t.string "secret_digest", null: false
    t.string "scope"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "authorization_codes", "clients"
  add_foreign_key "authorization_codes", "users"
  add_foreign_key "client_redirect_uris", "clients"
end
