# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "links", :force => true do |t|
    t.text     "website_url"
    t.string   "token"
    t.string   "permalink"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["token"], :name => "index_links_on_token"

  create_table "visits", :force => true do |t|
    t.integer  "link_id"
    t.text     "referral_link"
    t.string   "flagged"
    t.text     "ip_address"
    t.datetime "created_at"
  end

  add_index "visits", ["flagged"], :name => "index_visits_on_flagged"
  add_index "visits", ["link_id"], :name => "index_visits_on_link_id"

end
