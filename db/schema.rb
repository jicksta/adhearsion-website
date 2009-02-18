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

ActiveRecord::Schema.define(:version => 20090218053328) do

  create_table "example_sections", :force => true do |t|
    t.integer  "position"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_html"
  end

  create_table "examples", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "content_html"
    t.integer  "position"
    t.integer  "example_section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sandbox_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "identifier_hash"
    t.boolean  "receive_emails"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "skype"
    t.string   "identifier_hash"
    t.boolean  "receive_emails"
    t.string   "api_key"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
