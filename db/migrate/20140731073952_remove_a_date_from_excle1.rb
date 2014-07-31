class RemoveADateFromExcle1 < ActiveRecord::Migration
  def change
    remove_column :excle1s ,:a_date,:datetime
  end
end
