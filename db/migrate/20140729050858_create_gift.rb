class CreateGift < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.integer :app_id
      t.integer :amount
      t.string  :type
      t.string  :are_deduct_integral
      t.string  :applicable_time
      t.string  :detail
      t.integer :cards_id

      t.timestamps
    end
  end
end
