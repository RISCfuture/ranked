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

ActiveRecord::Schema.define(version: 2019_08_18_003428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.bigint "stack_id", null: false
    t.string "name", limit: 126, null: false
    t.index ["stack_id", "name"], name: "index_cards_on_stack_id_and_name", unique: true
    t.index ["stack_id"], name: "index_cards_on_stack_id"
  end

  create_table "stacks", force: :cascade do |t|
    t.string "name", limit: 126, null: false
    t.text "pairs_order", null: false
    t.datetime "created_at", null: false
  end

  add_foreign_key "cards", "stacks", on_delete: :cascade
end
