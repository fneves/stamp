# This migration comes from stamp (originally 20131103141804)
class CreateStampReservations < ActiveRecord::Migration
  def change
    create_table :stamp_reservations do |t|
      t.integer :customer_id
      t.references :service
      t.decimal :total_price
      t.timestamps
    end
  end
end
