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

ActiveRecord::Schema.define(version: 20150416220930) do

  create_table "teste1s", force: :cascade do |t|
    t.string   "descricao"
    t.integer  "teste_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teste1s", ["teste_id"], name: "index_teste1s_on_teste_id"

  create_table "testes", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
