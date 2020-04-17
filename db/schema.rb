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

ActiveRecord::Schema.define(version: 2020_04_17_220012) do

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "imageSource"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "toUser"
    t.text "booksOffered"
    t.text "booksWanted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_exchanges_on_user_id"
  end

  create_table "swap_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "toUser"
    t.text "booksOffered"
    t.text "booksWanted"
    t.boolean "isPending"
    t.boolean "isAccepted"
    t.integer "ancestorRequest"
    t.integer "childRequest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_swap_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.string "title"
    t.integer "bookAmount"
    t.integer "buy"
    t.integer "sell"
    t.decimal "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "imageSource"
  end

  add_foreign_key "books", "users"
  add_foreign_key "exchanges", "users"
  add_foreign_key "swap_requests", "users"
end
