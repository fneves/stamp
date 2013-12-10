module Stamp
  class Service < ActiveRecord::Base
    has_one :stamp_service_type, :class_name => 'Stamp::ServiceType'


    def availability(start_timestamp, end_timestamp)


    end

    def booked_slots(start_timestamp, end_timestamp)
      TimeSlot.where( from: start_timestamp .. end_timestamp, id: id).order(:from)
    end

  end
end
