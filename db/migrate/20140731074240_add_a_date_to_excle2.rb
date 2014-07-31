class AddADateToExcle2 < ActiveRecord::Migration
  def change
    add_column :excle2s, :a_date,:date
  end
end
