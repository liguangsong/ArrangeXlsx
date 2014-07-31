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

ActiveRecord::Schema.define(version: 20140731105458) do

  create_table "excels", force: true do |t|
    t.string   "excel_file_name"
    t.string   "excel_content_type"
    t.integer  "excel_file_size"
    t.datetime "excel_updated_at"
  end

  create_table "excle1s", force: true do |t|
    t.string "b_opening"
    t.string "c_max"
    t.string "d_min"
    t.string "e_close"
    t.string "f_volume"
    t.string "g_turnover"
    t.string "h_traded_items"
    t.string "i_ma1"
    t.string "j_ma2"
    t.string "k_ma3"
    t.string "l_ma4"
    t.string "m_ma5"
    t.string "n_ma6"
    t.date   "a_date"
  end

  create_table "excle2s", force: true do |t|
    t.string "b_opening"
    t.string "c_max"
    t.string "d_min"
    t.string "e_close"
    t.string "f_volume"
    t.string "g_turnover"
    t.string "h_traded_items"
    t.string "i_ma1"
    t.string "j_ma2"
    t.string "k_ma3"
    t.string "l_ma4"
    t.string "m_ma5"
    t.string "n_ma6"
    t.date   "a_date"
  end

  create_table "excle_dates", force: true do |t|
    t.string "name"
    t.string "number"
    t.string "status"
  end

  create_table "gifts", force: true do |t|
    t.integer  "app_id"
    t.integer  "amount"
    t.string   "type"
    t.string   "are_deduct_integral"
    t.string   "applicable_time"
    t.string   "detail"
    t.integer  "cards_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "xlsxes", force: true do |t|
  end

end
