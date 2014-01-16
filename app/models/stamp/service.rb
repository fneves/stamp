module Stamp
  class Service < ActiveRecord::Base
    belongs_to :stamp_service_type, :class_name => 'Stamp::ServiceType', :foreign_key => "service_type_id"
    has_many :stamp_pre_reservations, :class_name => 'Stamp::PreReservation', :foreign_key => "service_id"
    has_many :stamp_reservations, :class_name => 'Stamp::Reservation', :foreign_key => "service_id"
    has_many :stamp_price_ratings, :class_name => 'Stamp::PriceRating', :foreign_key => "service_id"

    ONLINE_PAYMENT = 0
    ASYNC_PAYMENT = 1

    validates_presence_of :name, :external_id, :opening_hours, :closing_hours, :period_size,
                          :service_type_id, :owner_id, :payment_method
    validate :service_type_exists
    validates_inclusion_of :payment_method, in: [ONLINE_PAYMENT, ASYNC_PAYMENT]


    def availability(start_timestamp, end_timestamp)
      occupied_slots = booked_slots(start_timestamp, end_timestamp)
      availability = (start_timestamp.to_date..end_timestamp.to_date).map do |date|
        daily_occupied_slots = occupied_slots[date]
        [date, gen_daily_calendar(date, daily_occupied_slots)]
      end
      Hash[availability]
    end

    def booked_slots(start_timestamp, end_timestamp)
      booked_slots = TimeSlot.where( from: start_timestamp .. end_timestamp, service_id: id).order(:from)
      booked_slots.inject({}) do |result, booked_slot|
        slot_date = booked_slot.from.to_date
        result[slot_date] = [] unless result[slot_date]
        result[slot_date].push(build_time_slot(booked_slot.from.to_datetime, booked_slot.units))
        result
      end
    end

    def gen_opening_hours(date)
      date.to_datetime + Rational(opening_hours, 1.day.to_i)
    end

    def gen_closing_hours(date)
      date.to_datetime + Rational(closing_hours, 1.day.to_i)
    end

    private

    def free_periods(timestamp1, timestamp2)
      ((timestamp2.to_time - timestamp1.to_time).round/60/period_size).round
    end

    def service_type_exists
      if !ServiceType.where(id: service_type_id).exists? then
        errors.add(:service_type_id, 'A valid service type is required.')
      end
    end

    #INFO this method can be executed in parallel!!!
    def gen_daily_calendar(target_date, booked_slots)
      booked_slots||=[]
      start_time = gen_opening_hours(target_date)
      end_time = gen_closing_hours(target_date)
      first_booked_slot = booked_slots.shift
      result = []
      while(start_time < end_time) do
        if first_booked_slot.nil? || start_time < first_booked_slot[:start]
          time_slot = build_time_slot(start_time)
          result.push(time_slot)
          start_time = time_slot[:end]
        else
          start_time = first_booked_slot[:end]
          first_booked_slot = booked_slots.shift
        end
      end
      result
    end

    def build_time_slot(from_timestamp, units = 1)
        {start: from_timestamp, end: from_timestamp + Rational((units * period_size),1.day.to_i)}
    end
  end
end
