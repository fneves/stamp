module Stamp
  class PriceRating < ActiveRecord::Base
    belongs_to :stamp_service, :class_name => 'Stamp::Service'
  end
end
