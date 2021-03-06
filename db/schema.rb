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

ActiveRecord::Schema.define(version: 20141030214249) do

  create_table "battings", force: true do |t|
    t.integer "player_id"
    t.integer "year"
    t.string  "league"
    t.string  "team"
    t.integer "g"
    t.integer "at_bats"
    t.integer "r"
    t.integer "hits"
    t.integer "doubles"
    t.integer "triples"
    t.integer "home_runs"
    t.integer "runs_batted_in"
    t.integer "sb"
    t.integer "cs"
  end

  add_index "battings", ["player_id"], name: "index_battings_on_player_id"

  create_table "players", force: true do |t|
    t.string  "uid"
    t.integer "birth_year"
    t.string  "first_name"
    t.string  "last_name"
  end

end
