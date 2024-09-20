# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_20_094656) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "displayName"
    t.string "email"
    t.string "password"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "auctions", force: :cascade do |t|
    t.bigint "item_id"
    t.datetime "startTime", precision: nil
    t.datetime "endTime", precision: nil
    t.decimal "currentPrice"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "admin_message"
    t.index ["item_id"], name: "index_auctions_on_item_id"
  end

  create_table "bids", force: :cascade do |t|
    t.bigint "auction_id"
    t.bigint "bidder_id"
    t.decimal "amount"
    t.datetime "timestamp", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_bids_on_auction_id"
    t.index ["bidder_id"], name: "index_bids_on_bidder_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "startingPrice"
    t.bigint "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_items_on_seller_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "auction_id"
    t.bigint "buyer_id"
    t.decimal "amount"
    t.string "status"
    t.datetime "timestamp", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_payments_on_auction_id"
    t.index ["buyer_id"], name: "index_payments_on_buyer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "auctions", "items"
  add_foreign_key "bids", "accounts", column: "bidder_id"
  add_foreign_key "bids", "auctions"
  add_foreign_key "items", "accounts", column: "seller_id"
  add_foreign_key "payments", "accounts", column: "buyer_id"
  add_foreign_key "payments", "auctions"
end
