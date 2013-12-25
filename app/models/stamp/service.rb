module Stamp
  class Service < ActiveRecord::Base
    belongs_to :stamp_service_type, :class_name => 'Stamp::ServiceType'
    has_many :stamp_pre_reservations, :class_name => 'Stamp::PreReservation'
    has_many :stamp_reservations, :class_name => 'Stamp::Reservation'
    has_many :stamp_price_ratings, :class_name => 'Stamp::PriceRating'

    validates_presence_of :name, :external_id, :opening_hours, :closing_hours, :period_size, :service_type_id, :owner_id
    validate :service_type_exists


    def availability(start_timestamp, end_timestamp)

    end

    def booked_slots(start_timestamp, end_timestamp)
      booked_slots = TimeSlot.where( from: start_timestamp .. end_timestamp, id: id).order(:from)
      daily_buckets = {}
      booked_slots.each do |booked_slot|
        daily_slots = daily_buckets[booked_slot.to_date]
        daily_slots = [] if daily_slots.nil?
        end_time = booked_slot.from + (booked_slot.units * period_size).minutes
        daily_slots.push({ start: booked_slot.from, end:end_time})
      end
      daily_buckets
    end

    private

    def service_type_exists
      if !ServiceType.where(id: service_type_id).exists? then
        errors.add(:service_type_id, 'A valid service type is required.')
      end
    end

  end
end
