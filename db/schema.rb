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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130123150811) do

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "phone"
    t.string   "website"
    t.string   "city"
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "businesses", ["user_id"], :name => "index_businesses_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "contact_name"
    t.integer  "contact_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "customers", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "last_4_digits"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "farms", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "phone"
    t.string   "website"
    t.integer  "rate"
    t.integer  "capacity"
    t.string   "city"
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "mainimage_file_name"
    t.string   "mainimage_content_type"
    t.integer  "mainimage_file_size"
    t.datetime "mainimage_updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  add_index "farms", ["user_id"], :name => "index_farms_on_user_id"

  create_table "horses", :force => true do |t|
    t.string   "name"
    t.string   "breed"
    t.string   "gender"
    t.date     "dob"
    t.decimal  "height"
    t.text     "text_description"
    t.decimal  "price"
    t.integer  "user_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "city"
    t.string   "state"
    t.string   "sale_status"
    t.string   "status"
    t.boolean  "flagged"
    t.boolean  "active"
    t.string   "mainimage_file_name"
    t.string   "mainimage_content_type"
    t.integer  "mainimage_file_size"
    t.datetime "mainimage_updated_at"
    t.string   "image1_file_name"
    t.string   "image1_content_type"
    t.integer  "image1_file_size"
    t.datetime "image1_updated_at"
    t.string   "image2_file_name"
    t.string   "image2_content_type"
    t.integer  "image2_file_size"
    t.datetime "image2_updated_at"
    t.string   "image3_file_name"
    t.string   "image3_content_type"
    t.integer  "image3_file_size"
    t.datetime "image3_updated_at"
    t.string   "image4_file_name"
    t.string   "image4_content_type"
    t.integer  "image4_file_size"
    t.datetime "image4_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.boolean  "gmaps"
  end

  add_index "horses", ["user_id"], :name => "index_horses_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "to_user_id"
    t.string   "from_user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "sent"
    t.integer  "thread_count"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "folder"
    t.integer  "parent_id"
    t.boolean  "read"
    t.string   "name"
  end

  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "months"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "saved_horses", :force => true do |t|
    t.decimal  "horse_id"
    t.boolean  "saved"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.integer  "number_of_listings"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "stripe_customer_token"
    t.string   "email"
    t.integer  "horse_id"
    t.string   "state"
  end

  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "testimonials", :force => true do |t|
    t.text     "body"
    t.integer  "horse_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "voucher_id"
  end

  add_index "testimonials", ["user_id"], :name => "index_testimonials_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "phone_number",           :limit => 8
    t.string   "website"
    t.string   "preferred_contact"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.text     "bio"
    t.string   "status"
    t.boolean  "flagged"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "profession"
    t.boolean  "professional_listing"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "videos", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "video_remote_url"
    t.integer  "horse_id"
  end

end
