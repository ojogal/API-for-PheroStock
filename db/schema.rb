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

ActiveRecord::Schema[7.0].define(version: 2022_09_16_142336) do
  create_table "chemicals", force: :cascade do |t|
    t.string "chemical_name"
    t.string "synonym"
    t.string "cas"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chemicals_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_chemicals", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "chemical_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chemical_id"], name: "index_company_chemicals_on_chemical_id"
    t.index ["company_id"], name: "index_company_chemicals_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "chemicals", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "company_chemicals", "chemicals"
  add_foreign_key "company_chemicals", "companies"
end
