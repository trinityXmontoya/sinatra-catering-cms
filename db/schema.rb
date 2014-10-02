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

ActiveRecord::Schema.define(version: 20141002071952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "gallery_images", force: true do |t|
    t.string "url"
  end

  create_table "menu_items", force: true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "category_id"
  end

  create_table "site_info", force: true do |t|
    t.string "header_img"
    t.string "header_description"
    t.string "services_byline"
    t.text   "event_description"
    t.text   "home_description"
    t.text   "office_description"
    t.string "about_img"
    t.string "about_name"
    t.string "about_byline"
    t.text   "about_description"
    t.string "contact_img"
    t.string "contact_byline"
    t.string "menu_bg_img"
  end

  create_table "testimonials", force: true do |t|
    t.string  "name"
    t.string  "event"
    t.string  "comment"
    t.boolean "hidden",   default: false
    t.boolean "approved", default: false
  end

end
