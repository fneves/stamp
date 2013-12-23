module Stamp
  class TimeSlot < ActiveRecord::Base
    belongs_to :stamp_reservation, :class_name => 'Stamp::Reservation'
    belongs_to :stamp_pre_reservation, :class_name => 'Stamp::PreReservation'
    belongs_to :stamp_service, :class_name => 'Stamp::Service'
  end
end
