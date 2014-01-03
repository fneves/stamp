FactoryGirl.define do

  factory :customer, class: User do
    name "Test User"
  end

  factory :service_type, class: Stamp::ServiceType do
    sequence(:name){|n| "service type #{n}"}
  end

  factory :service, class: Stamp::Service do
    sequence(:name){|n| "service #{n}"}
    sequence(:external_id){|n| "external #{n}"}
    sequence(:opening_hours){|n| " 10:#{n}#{n}"}
    sequence(:closing_hours){|n| " 24:#{n}#{n}"}
    period_size 30
    payment_method 0
    owner_id 1
    service_type_id nil
  end

  factory :reservation, class: Stamp::Reservation do
    customer_id 1
    total_price 100
    service_id { Stamp::Service.first.id }
  end

  factory :pre_reservation, class: Stamp::PreReservation do
    customer_id 1
    total_price 100
    service_id { Stamp::Service.first.id }
  end

  factory :time_slot, class: Stamp::TimeSlot do
    from "2014-01-01 10:00:00"
    reservation_id { Stamp::Reservation.first.id }
    service_id { Stamp::Service.first.id }
    units 1
  end

  factory :price_rating, class: Stamp::PriceRating do
    from "2013-10-10 10:00:00"
    from "2014-10-10 10:00:00"
    service_id { Stamp::Service.first.id }
    value 10.5
  end

end