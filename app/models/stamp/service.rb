module Stamp
  class Service < ActiveRecord::Base
    belongs_to :stamp_service_type, :class_name => 'Stamp::ServiceType'
    has_many :stamp_pre_reservations, :class_name => 'Stamp::PreReservation'
    has_many :stamp_reservations, :class_name => 'Stamp::Reservation'
    has_many :stamp_price_ratings, :class_name => 'Stamp::PriceRating'

    def availability(start_timestamp, end_timestamp)

    end

    def booked_slots(start_timestamp, end_timestamp)
      TimeSlot.where( from: start_timestamp .. end_timestamp, id: id).order(:from)
    end

  end
end
