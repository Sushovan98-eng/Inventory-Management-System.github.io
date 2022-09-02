# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_803_052_648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'allotments', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'item_id'
    t.integer 'allotment_quantity'
    t.datetime 'dealloted_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_allotments_on_item_id'
    t.index ['user_id'], name: 'index_allotments_on_user_id'
  end

  create_table 'brands', force: :cascade do |t|
    t.string 'name'
    t.string 'manufacturer'
    t.string 'manufacturer_email'
    t.string 'manufacturer_office'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_brands_on_name', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_categories_on_name', unique: true
  end

  create_table 'issues', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'item_id'
    t.text 'issue_description'
    t.datetime 'solved_at'
    t.text 'feedback'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_issues_on_item_id'
    t.index ['user_id'], name: 'index_issues_on_user_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.bigint 'brand_id'
    t.bigint 'category_id'
    t.integer 'in_stock'
    t.decimal 'price'
    t.integer 'minimum_required_stock'
    t.integer 'total_stock'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'new_stock'
    t.index ['brand_id'], name: 'index_items_on_brand_id'
    t.index ['category_id'], name: 'index_items_on_category_id'
    t.index ['name'], name: 'index_items_on_name', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'admin', default: false
    t.string 'mobile_no', limit: 10, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['mobile_no'], name: 'index_users_on_mobile_no', unique: true
  end

  add_foreign_key 'allotments', 'items'
  add_foreign_key 'allotments', 'users'
  add_foreign_key 'issues', 'items'
  add_foreign_key 'issues', 'users'
  add_foreign_key 'items', 'brands'
  add_foreign_key 'items', 'categories'
end
