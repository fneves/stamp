# This migration comes from stamp (originally 20140116003541)
class TimeSlot < ActiveRecord::Migration
  def change

    create_table :stamp_time_slots do |t|
      t.belongs_to :reservation
      t.belongs_to :service
      t.datetime :from
      t.integer :units
      t.timestamps
    end

  end
end
