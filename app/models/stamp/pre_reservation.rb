module Stamp
  class PreReservation < ActiveRecord::Base
    attr_accessor :customer_id
    belongs_to :customer, class_name: Stamp.customer_class.to_s

    before_save :set_customer
    after_find :set_customer

    private

    def set_customer
      self.customer = Stamp.customer_class.find(customer_id)
    end

  end
end
