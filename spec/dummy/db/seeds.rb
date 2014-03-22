# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

puts "Fill database with dummy data (Expect an user with id 1)"


Stamp::ServiceType.create(name:'pizza hut',service_type_id:1)

Stamp::PriceRating.create(service_id:1, from:Time.now, to:Time.now,value:15)

Stamp::Reservation.create(customer_id:1, service_id:1, total_price:100)
Stamp::PreReservation.create(customer_id:1, service_id:1, total_price:95)

Stamp::TimeSlot.create(reservation_id:1, pre_reservation_id:1, service_id:1, from:Time.now, units:6)

##NOT WORKING Must check why
Stamp::Service.create(owner_id:1,name:'pizza hut',opening_hours:10, closing_hours:18, period_size:30, payment_method:0, owner_id: 1, service_type_id: 1)

