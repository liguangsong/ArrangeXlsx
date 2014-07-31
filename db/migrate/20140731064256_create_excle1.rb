class CreateExcle1 < ActiveRecord::Migration
  def change
    create_table :excle1s do |t|
      t.datetime :a_date
      t.string :b_opening
      t.string :c_max
      t.string :d_min
      t.string :e_close
      t.string :f_volume
      t.string :g_turnover
      t.string :h_traded_items
      t.string :i_ma1
      t.string :j_ma2
      t.string :k_ma3
      t.string :l_ma4
      t.string :m_ma5
      t.string :n_ma6
    end
  end
end
