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

ActiveRecord::Schema.define(version: 2020_01_13_114235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name", default: "Unknown", null: false
    t.integer "redirects_count", default: 0
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.string "token", null: false
    t.integer "redirects_count", default: 0, null: false
    t.index ["token"], name: "index_links_on_token", unique: true
    t.index ["url"], name: "index_links_on_url", unique: true
  end

  create_table "redirects", force: :cascade do |t|
    t.bigint "link_id"
    t.bigint "country_id"
    t.string "ip", default: "0.0.0.0", null: false
    t.index ["country_id"], name: "index_redirects_on_country_id"
    t.index ["link_id"], name: "index_redirects_on_link_id"
  end

end
