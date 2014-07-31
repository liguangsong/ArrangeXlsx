class CreateExcleDate < ActiveRecord::Migration
  def change
    create_table :excle_dates do |t|
      t.string :name
      t.string :number
      t.string :status
    end
  end
end
