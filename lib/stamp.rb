require "stamp/engine"

module Stamp
  mattr_accessor :customer_class

  def self.customer_class
    @@customer_class.constantize
  end
end
