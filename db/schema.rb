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

ActiveRecord::Schema.define(version: 2019_12_31_031052) do

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

end
