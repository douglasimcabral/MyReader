ActiveRecord::Schema.define(version: 20150417122823) do

  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.integer  "feed_id"
    t.string   "atom_id"
    t.string   "title"
    t.string   "url"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end