# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140211160502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cupboard_ingredients", force: true do |t|
    t.integer  "cupboard_id"
    t.integer  "ingredient_id"
    t.integer  "quantity"
    t.string   "measurement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cupboards", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
  end

  create_table "list_ingredients", force: true do |t|
    t.integer  "shopping_list_id"
    t.integer  "ingredient_id"
    t.integer  "quantity"
    t.string   "measurement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "raw_name"
  end

  create_table "recipe_ingredients", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.string   "source_url"
    t.string   "servings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "recipes_shopping_lists", id: false, force: true do |t|
    t.integer "shopping_list_id", null: false
    t.integer "recipe_id",        null: false
  end

  create_table "shopping_lists", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_email"
  end

end
