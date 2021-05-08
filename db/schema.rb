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

ActiveRecord::Schema.define(version: 20210508071352) do

  create_table "carts", force: :cascade do |t|
    t.integer  "quantity",   default: 0
    t.decimal  "subtotal"
    t.decimal  "total"
    t.decimal  "tax"
    t.integer  "order_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_carts_on_order_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
    t.string   "contact"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "remaining_quantity"
    t.integer  "price",              default: 0, null: false
    t.integer  "company_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "quantity",  default: 0
    t.integer "price",     default: 0
    t.float   "sub_total", default: 0.0
    t.integer "item_id"
    t.integer "cart_id"
    t.integer "order_id"
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["item_id"], name: "index_line_items_on_item_id"
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "quantity"
    t.boolean  "status"
    t.date     "expire_at"
    t.integer  "item_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.index ["item_id"], name: "index_orders_on_item_id"
    t.index ["member_id"], name: "index_orders_on_member_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone"
    t.integer  "role",                   default: 0
    t.string   "company_name"
    t.string   "address"
    t.string   "stripe_token"
    t.string   "token_updated_at"
    t.integer  "company_id"
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
