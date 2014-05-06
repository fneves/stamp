# This migration comes from stamp (originally 20131103141810)
class CreateStampPreReservations < ActiveRecord::Migration
  def change
    create_table :stamp_pre_reservations do |t|
      t.integer :customer_id
      t.references :service
      t.decimal :total_price
      t.timestamps
    end
  end
end
