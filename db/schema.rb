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

ActiveRecord::Schema.define(version: 2019_12_29_230242) do

  create_table "archangel_assets", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "file_name"
    t.string "file"
    t.string "content_type"
    t.integer "file_size"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_assets_on_deleted_at"
    t.index ["file_name"], name: "index_archangel_assets_on_file_name", unique: true
    t.index ["site_id"], name: "index_archangel_assets_on_site_id"
  end

  create_table "archangel_collections", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "name"
    t.string "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_collections_on_deleted_at"
    t.index ["name"], name: "index_archangel_collections_on_name"
    t.index ["site_id"], name: "index_archangel_collections_on_site_id"
    t.index ["slug"], name: "index_archangel_collections_on_slug"
  end

  create_table "archangel_designs", force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "parent_id"
    t.string "name"
    t.text "content", default: ""
    t.boolean "partial"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_designs_on_deleted_at"
    t.index ["parent_id"], name: "index_archangel_designs_on_parent_id"
    t.index ["site_id"], name: "index_archangel_designs_on_site_id"
  end

  create_table "archangel_entries", force: :cascade do |t|
    t.integer "collection_id", null: false
    t.text "value"
    t.integer "position"
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_archangel_entries_on_collection_id"
    t.index ["deleted_at"], name: "index_archangel_entries_on_deleted_at"
    t.index ["position"], name: "index_archangel_entries_on_position"
    t.index ["published_at"], name: "index_archangel_entries_on_published_at"
  end

  create_table "archangel_fields", force: :cascade do |t|
    t.integer "collection_id", null: false
    t.string "label"
    t.string "slug"
    t.string "value"
    t.string "classification"
    t.boolean "required"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classification"], name: "index_archangel_fields_on_classification"
    t.index ["collection_id"], name: "index_archangel_fields_on_collection_id"
    t.index ["deleted_at"], name: "index_archangel_fields_on_deleted_at"
    t.index ["label"], name: "index_archangel_fields_on_label"
    t.index ["required"], name: "index_archangel_fields_on_required"
    t.index ["slug"], name: "index_archangel_fields_on_slug"
  end

  create_table "archangel_pages", force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "parent_id"
    t.integer "design_id"
    t.string "title"
    t.string "slug"
    t.string "permalink"
    t.text "content", default: ""
    t.boolean "homepage", default: false
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_pages_on_deleted_at"
    t.index ["design_id"], name: "index_archangel_pages_on_design_id"
    t.index ["homepage"], name: "index_archangel_pages_on_homepage"
    t.index ["parent_id"], name: "index_archangel_pages_on_parent_id"
    t.index ["permalink"], name: "index_archangel_pages_on_permalink"
    t.index ["published_at"], name: "index_archangel_pages_on_published_at"
    t.index ["site_id"], name: "index_archangel_pages_on_site_id"
    t.index ["slug"], name: "index_archangel_pages_on_slug"
    t.index ["title"], name: "index_archangel_pages_on_title"
  end

  create_table "archangel_sites", force: :cascade do |t|
    t.string "name", default: "Archangel", null: false
    t.string "theme"
    t.string "locale", default: "en", null: false
    t.string "logo"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "settings"
    t.index ["deleted_at"], name: "index_archangel_sites_on_deleted_at"
    t.index ["name"], name: "index_archangel_sites_on_name"
  end

  create_table "archangel_users", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "name", default: "", null: false
    t.string "username", default: "", null: false
    t.string "role"
    t.string "avatar"
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
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "preferences"
    t.index ["confirmation_token"], name: "index_archangel_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_archangel_users_on_deleted_at"
    t.index ["email"], name: "index_archangel_users_on_email"
    t.index ["invitation_token"], name: "index_archangel_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_archangel_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_archangel_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_archangel_users_on_invited_by_type_and_invited_by_id"
    t.index ["name"], name: "index_archangel_users_on_name"
    t.index ["reset_password_token"], name: "index_archangel_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_archangel_users_on_role"
    t.index ["site_id"], name: "index_archangel_users_on_site_id"
    t.index ["unlock_token"], name: "index_archangel_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_archangel_users_on_username"
  end

  create_table "archangel_widgets", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "name"
    t.string "slug"
    t.text "content"
    t.integer "design_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_widgets_on_deleted_at"
    t.index ["design_id"], name: "index_archangel_widgets_on_design_id"
    t.index ["name"], name: "index_archangel_widgets_on_name"
    t.index ["site_id"], name: "index_archangel_widgets_on_site_id"
    t.index ["slug"], name: "index_archangel_widgets_on_slug"
  end

  create_table "designs", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.boolean "partial"
    t.integer "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.string "permalink"
    t.text "content"
    t.boolean "homepage"
    t.integer "parent_id"
    t.integer "design_id"
    t.datetime "deleted_at"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "theme"
    t.string "locale"
    t.text "settings"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "content"
    t.integer "design_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
