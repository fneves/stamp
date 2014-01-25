module Stamp
  class PreReservation < ActiveRecord::Base
    belongs_to :customer, class_name: Stamp.customer_class.to_s
    has_one :stamp_time_slot, :class_name => 'Stamp::TimeSlot', :foreign_key => "pre_reservation_id"
    belongs_to :stamp_service, :class_name => 'Stamp::Service', :foreign_key => "service_id"

    validates_presence_of :total_price

    before_save :set_customer
    after_find :set_customer

    private

    def set_customer
      self.customer = Stamp.customer_class.find(customer_id)
    end

  end
end
