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
    opening_hours 10.hours
    closing_hours 20.hours
    period_size 30.minutes
    payment_method 0
    owner_id 1
    service_type_id nil
  end

  factory :reservation, class: Stamp::Reservation do
    customer_id 1
    total_price 100
    service_id { Stamp::Service.first.id }
  end

  factory :invalid_reservation, class: Stamp::Reservation do
    customer_id 1
    total_price nil
    service_id nil
  end

  factory :pre_reservation, class: Stamp::PreReservation do
    customer_id 1
    total_price 100
    service_id { Stamp::Service.first.id }
  end

  factory :time_slot, class: Stamp::TimeSlot do
    from DateTime.parse("2014-01-01 10:00:00")
    reservation_id { Stamp::Reservation.first.id }
    pre_reservation_id { Stamp::PreReservation.first.id }
    service_id { Stamp::Service.first.id }
    units 1
  end

  factory :price_rating, class: Stamp::PriceRating do
    from "2013-10-10 10:00:00"
    to "2014-10-10 10:00:00"
    service_id { Stamp::Service.first.id }
    value 10.5
  end

end