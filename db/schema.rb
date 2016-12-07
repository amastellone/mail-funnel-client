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

ActiveRecord::Schema.define(version: 20161207014028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_configs", force: :cascade do |t|
    t.string "name"
    t.string "value"
  end

  create_table "apps", force: :cascade do |t|
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "hooks_constants", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
    t.string   "type"
    t.string   "hook_type"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer  "hook"
    t.datetime "created_at",        :null=>false
    t.datetime "updated_at",        :null=>false
    t.integer  "hooks_constant_id", :foreign_key=>{:references=>"hooks_constants", :name=>"fk_campaigns_hooks_constant_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__campaigns_hooks_constant_id", :using=>:btree}
    t.string   "name"
    t.string   "hook_identifier"
  end

  create_table "campaign_jobs", force: :cascade do |t|
    t.integer  "job"
    t.integer  "position"
    t.datetime "created_at",        :null=>false
    t.datetime "updated_at",        :null=>false
    t.integer  "hooks_constant_id", :foreign_key=>{:references=>"hooks_constants", :name=>"fk_campaign_jobs_hooks_constant_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__campaign_jobs_hooks_constant_id", :using=>:btree}
    t.integer  "campaign_id",       :foreign_key=>{:references=>"campaigns", :name=>"fk_campaign_jobs_campaign_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__campaign_jobs_campaign_id", :using=>:btree}
  end

  create_table "configs", force: :cascade do |t|
    t.string "name"
    t.string "value"
  end

  create_table "emails", force: :cascade do |t|
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "emails_lists", force: :cascade do |t|
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "jobs", force: :cascade do |t|
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "mail_funnel_configs", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "shopify_domain", :null=>false, :index=>{:name=>"index_shops_on_shopify_domain", :unique=>true, :using=>:btree}
    t.string   "shopify_token",  :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "app"
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

end
