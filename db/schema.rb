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

ActiveRecord::Schema.define(version: 2020_01_02_232514) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assets", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_assets_on_deleted_at"
    t.index ["name"], name: "index_assets_on_name", unique: true
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_collections_on_deleted_at"
    t.index ["name"], name: "index_collections_on_name"
    t.index ["slug"], name: "index_collections_on_slug"
  end

  create_table "designs", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", default: ""
    t.boolean "partial", default: false
    t.integer "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_designs_on_deleted_at"
    t.index ["parent_id"], name: "index_designs_on_parent_id"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "collection_id", null: false
    t.text "value"
    t.integer "position"
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"available_at\"", name: "index_entries_on_available_at"
    t.index ["collection_id"], name: "index_entries_on_collection_id"
    t.index ["deleted_at"], name: "index_entries_on_deleted_at"
    t.index ["position"], name: "index_entries_on_position"
  end

  create_table "fields", force: :cascade do |t|
    t.integer "collection_id", null: false
    t.string "label"
    t.string "slug"
    t.string "default_value"
    t.string "classification"
    t.boolean "required"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classification"], name: "index_fields_on_classification"
    t.index ["collection_id"], name: "index_fields_on_collection_id"
    t.index ["deleted_at"], name: "index_fields_on_deleted_at"
    t.index ["label"], name: "index_fields_on_label"
    t.index ["required"], name: "index_fields_on_required"
    t.index ["slug"], name: "index_fields_on_slug"
  end

  create_table "metatags", force: :cascade do |t|
    t.string "metatagable_type", null: false
    t.integer "metatagable_id", null: false
    t.string "name", null: false
    t.string "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["metatagable_id", "metatagable_type"], name: "index_metatags_on_metatagable_id_and_type"
    t.index ["metatagable_type", "metatagable_id"], name: "index_metatags_on_metatagable_type_and_metatagable_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "permalink"
    t.text "content", default: ""
    t.boolean "homepage", default: false
    t.integer "parent_id"
    t.integer "design_id"
    t.datetime "deleted_at"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_pages_on_deleted_at"
    t.index ["design_id"], name: "index_pages_on_design_id"
    t.index ["homepage"], name: "index_pages_on_homepage"
    t.index ["parent_id"], name: "index_pages_on_parent_id"
    t.index ["permalink"], name: "index_pages_on_permalink"
    t.index ["published_at"], name: "index_pages_on_published_at"
    t.index ["slug"], name: "index_pages_on_slug"
    t.index ["title"], name: "index_pages_on_title"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", default: "Archangel", null: false
    t.string "theme"
    t.string "locale", default: "en", null: false
    t.text "settings"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_sites_on_deleted_at"
    t.index ["name"], name: "index_sites_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "username", default: "", null: false
    t.string "role"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.text "preferences"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "content", default: ""
    t.integer "design_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_widgets_on_deleted_at"
    t.index ["design_id"], name: "index_widgets_on_design_id"
    t.index ["name"], name: "index_widgets_on_name"
    t.index ["slug"], name: "index_widgets_on_slug"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
