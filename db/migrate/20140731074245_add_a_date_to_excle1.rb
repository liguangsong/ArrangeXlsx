class AddADateToExcle1 < ActiveRecord::Migration
  def change
    add_column :excle1s, :a_date,:date
  end
end
