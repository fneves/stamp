class CreateStampCreditCards < ActiveRecord::Migration
  def change
    create_table :stamp_credit_cards do |t|
      t.integer :customer_id
      t.integer :card_number
      t.string :name
      t.integer :exp_date_month
      t.integer :exp_date_year

      t.timestamps
    end
  end
end
