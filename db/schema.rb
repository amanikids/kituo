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

ActiveRecord::Schema.define(:version => 20090923113720) do

  create_table "caregivers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "headshot_file_name"
    t.string   "headshot_content_type"
    t.integer  "headshot_file_size"
    t.datetime "headshot_updated_at"
    t.string   "role",                  :default => "social_worker", :null => false
  end

  create_table "children", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "headshot_file_name"
    t.string   "headshot_content_type"
    t.integer  "headshot_file_size"
    t.datetime "headshot_updated_at"
    t.integer  "social_worker_id"
    t.string   "location",              :default => "",        :null => false
    t.string   "state",                 :default => "unknown", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "child_id"
    t.date     "happened_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "events", ["child_id"], :name => "index_events_on_child_id"
  add_index "events", ["created_at"], :name => "index_events_on_created_at"
  add_index "events", ["happened_on"], :name => "index_events_on_happened_on"
  add_index "events", ["type"], :name => "index_events_on_type"

  create_table "scheduled_visits", :force => true do |t|
    t.integer  "child_id",      :null => false
    t.date     "scheduled_for", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "scheduled_visits", ["child_id", "scheduled_for"], :name => "index_scheduled_visits_on_child_id_and_scheduled_for"

end
