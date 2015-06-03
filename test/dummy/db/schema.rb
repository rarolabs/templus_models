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

ActiveRecord::Schema.define(version: 20150422191007) do

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id"

  create_table "enderecos", force: :cascade do |t|
    t.string   "cep"
    t.string   "logradouro"
    t.string   "complemento"
    t.string   "numero"
    t.string   "bairro"
    t.integer  "cidade_id"
    t.integer  "usuario_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "enderecos", ["cidade_id"], name: "index_enderecos_on_cidade_id"
  add_index "enderecos", ["usuario_id"], name: "index_enderecos_on_usuario_id"

  create_table "estados", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.datetime "locked_at"
    t.integer  "papel_id"
    t.boolean  "root",                   default: false
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["papel_id"], name: "index_usuarios_on_papel_id"
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end
