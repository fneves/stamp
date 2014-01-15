module Stamp
  class PreReservation < ActiveRecord::Base
    attr_accessor :customer_id
    #belongs_to :customer, class_name: Stamp.customer_class.to_s
    has_one :stamp_time_slot, :class_name => 'Stamp::TimeSlot'
    belongs_to :stamp_service, :class_name => 'Stamp::Service'

    #before_save :set_customer
    #after_find :set_customer

    private

    def set_customer
      puts "Stamp.customer_class"
      puts Stamp.customer_class.to_s
      self.customer = Stamp.customer_class.find(customer_id)
    end

  end
end
