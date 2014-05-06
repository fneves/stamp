# This migration comes from stamp (originally 20131103141615)
class AddPreReservationIdToStampTimeSlots < ActiveRecord::Migration

  def change
    add_column :stamp_time_slots, :pre_reservation_id, :integer
  end
end