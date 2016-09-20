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

ActiveRecord::Schema.define(version: 20160910114842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.integer  "photographer_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "photographer_id"
    t.string   "slug"
  end

  add_index "albums", ["slug"], name: "index_albums_on_slug", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "authentication_token"
    t.integer  "photographer_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "website"
    t.string   "contnumber"
    t.string   "title"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "city"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "enabled",                default: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.text     "description"
    t.boolean  "terms_and_condition"
  end

  add_index "clients", ["confirmation_token"], name: "index_clients_on_confirmation_token", unique: true, using: :btree
  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["invitation_token"], name: "index_clients_on_invitation_token", unique: true, using: :btree
  add_index "clients", ["invitations_count"], name: "index_clients_on_invitations_count", using: :btree
  add_index "clients", ["invited_by_id"], name: "index_clients_on_invited_by_id", using: :btree
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree

  create_table "enquiries", force: :cascade do |t|
    t.date     "event_date"
    t.string   "event_name"
    t.integer  "guests"
    t.integer  "client_id"
    t.integer  "photographer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "bridal"
    t.string   "groom"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "client_id"
    t.datetime "start_time"
    t.integer  "photographer_id"
    t.integer  "category_id"
    t.text     "description"
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "client_id"
    t.string   "url"
    t.boolean  "is_liked",           default: false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "likes_count",        default: 0
    t.integer  "status"
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "invite_clients", force: :cascade do |t|
    t.string   "email"
    t.integer  "photographer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "likes", force: :cascade do |t|
    t.boolean  "like"
    t.boolean  "unlike"
    t.integer  "client_id"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.integer  "picture_dslr_count"
    t.integer  "video_dslr_count"
    t.integer  "album_leaves"
    t.float    "other_city_charges"
    t.integer  "photographer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "description"
    t.integer  "price"
  end

  create_table "photographer_clients", force: :cascade do |t|
    t.integer  "photographer_id"
    t.integer  "client_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "advance"
    t.integer  "total"
    t.integer  "balance"
    t.boolean  "active",          default: true
    t.boolean  "is_connected",    default: false
    t.integer  "package_id"
    t.string   "token"
  end

  create_table "photographer_plans", force: :cascade do |t|
    t.datetime "expired_at"
    t.string   "status"
    t.integer  "plan_id"
    t.integer  "photographer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "photographers", force: :cascade do |t|
    t.string   "title"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "contnumber"
    t.string   "username"
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "client_id"
    t.integer  "event_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "package_id"
    t.integer  "memory_consumed",             default: 0,  null: false
    t.string   "website"
    t.string   "authentication_token"
    t.string   "watermark_logo_file_name"
    t.string   "watermark_logo_content_type"
    t.integer  "watermark_logo_file_size"
    t.datetime "watermark_logo_updated_at"
    t.string   "role_type"
    t.string   "city"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "description"
    t.datetime "expired_at"
    t.string   "plan_type"
    t.integer  "rating"
    t.string   "badge"
    t.string   "feature_image_file_name"
    t.string   "feature_image_content_type"
    t.integer  "feature_image_file_size"
    t.datetime "feature_image_updated_at"
    t.integer  "total_connects",              default: 1
    t.integer  "used_connects",               default: 0
    t.boolean  "terms_and_condition"
    t.string   "slug"
  end

  add_index "photographers", ["confirmation_token"], name: "index_photographers_on_confirmation_token", unique: true, using: :btree
  add_index "photographers", ["email"], name: "index_photographers_on_email", unique: true, using: :btree
  add_index "photographers", ["reset_password_token"], name: "index_photographers_on_reset_password_token", unique: true, using: :btree
  add_index "photographers", ["slug"], name: "index_photographers_on_slug", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "storage"
    t.integer  "connects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
