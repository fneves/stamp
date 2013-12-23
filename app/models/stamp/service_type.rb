module Stamp
  class ServiceType < ActiveRecord::Base
      has_many :stamp_services, :class_name => 'Stamp::Service'
  end
end
