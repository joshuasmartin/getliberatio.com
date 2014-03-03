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

ActiveRecord::Schema.define(version: 20140303023855) do

  create_table "applications", force: true do |t|
    t.string   "name"
    t.string   "publisher"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commands", force: true do |t|
    t.integer  "node_id"
    t.text     "executable"
    t.text     "arguments"
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
  end

  add_index "commands", ["node_id"], name: "index_commands_on_node_id"

  create_table "disks", force: true do |t|
    t.integer  "node_id"
    t.string   "disk_type"
    t.string   "file_system"
    t.string   "free_bytes"
    t.string   "total_bytes"
    t.string   "volume_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disks", ["node_id"], name: "index_disks_on_node_id"

  create_table "instances", force: true do |t|
    t.integer  "application_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "instances", ["application_id"], name: "index_instances_on_application_id"
  add_index "instances", ["node_id"], name: "index_instances_on_node_id"

  create_table "memories", force: true do |t|
    t.integer  "node_id"
    t.string   "capacity"
    t.string   "form_factor"
    t.string   "manufacturer"
    t.string   "memory_type"
    t.string   "speed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.string   "role"
    t.text     "location"
    t.string   "name"
    t.string   "operating_system"
    t.string   "serial_number"
    t.string   "model_number"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
    t.boolean  "is_managed",                default: true
    t.string   "architecture"
    t.string   "service_pack_update_level"
    t.datetime "inventoried_at"
    t.text     "token"
    t.datetime "token_created_at"
  end

  add_index "nodes", ["organization_id"], name: "index_nodes_on_organization_id"

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "registration_code"
  end

  create_table "processors", force: true do |t|
    t.integer  "node_id"
    t.string   "architecture"
    t.string   "name"
    t.string   "cores_count"
    t.string   "speed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: true do |t|
    t.integer  "ticket_id"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "organization_id"
    t.integer  "priority"
    t.string   "status"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "tickets", ["organization_id"], name: "index_tickets_on_organization_id"

  create_table "updates", force: true do |t|
    t.string  "title"
    t.integer "organization_id"
    t.integer "node_id"
    t.boolean "is_installed",    default: false
    t.string  "severity"
    t.string  "support_url"
  end

  add_index "updates", ["node_id"], name: "index_updates_on_node_id"
  add_index "updates", ["organization_id"], name: "index_updates_on_organization_id"

  create_table "users", force: true do |t|
    t.string   "email_address"
    t.string   "name"
    t.string   "password_digest"
    t.string   "role"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["organization_id"], name: "index_users_on_organization_id"

end
