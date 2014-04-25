module Stamp
  class CreditCard < ActiveRecord::Base
    belongs_to :customer, class_name: Stamp.customer_class.to_s

    validates_presence_of :customer_id, :card_number, :name, :exp_date_month, :exp_date_year

    before_save :set_customer
    after_find :set_customer

    private

    def set_customer
      self.customer = Stamp.customer_class.find(customer_id)
    end


  end
end
