class RemoveADateFromExcle2 < ActiveRecord::Migration
  def change
    remove_column :excle2s ,:a_date,:datetime
  end
end
