require 'spec_helper'

module Stamp
  describe Api::V1::ServicesController do



    context "create Services" do

      before(:all) do
        @service_type = create(:service_type)
        @service_type2 = create(:service_type)
      end

      describe "POST #create" do

        it "creates a service" do
          n_services = Service.all.size
          req = attributes_for(:service, service_type_id: @service_type2.id)
          post :create , service: req, use_route: :stamp
          expect(response.status).to eq(200)
          assert_equal n_services+1, Service.count
        end

        it "Can't create a service as there is no valid service type" do
          n_services = Service.all.size
          req = { name: 'Bakery 1', external_id:'external', opening_hours: '10:00',
                  closing_hours: '24:00', period_size: 1.0, service_type_id: -1, owner_id: 1}
          post :create , service: req, use_route: :stamp
          expect(response.status).to eq(422)
          assert_equal n_services, Service.count
        end

        it "Can't create a service as there is no service type" do
          n_services = Service.all.size
          req = { name: 'Bakery 1', external_id:'external', opening_hours: '10:00',
                  closing_hours: '24:00', period_size: 1.0, owner_id: 1}
          post :create , service: req, use_route: :stamp
          expect(response.status).to eq(422)
          assert_equal n_services, Service.count
        end

        it "Can't create a service as there is no owner" do
          n_services = Service.all.size
          req = { name: 'Bakery 1', external_id:'external', opening_hours: '10:00',
                  closing_hours: '24:00', period_size: 1.0, service_type: @service_type.id}
          post :create ,  service: req , use_route: :stamp
          expect(response.status).to eq(422)
          assert_equal n_services, Service.count
        end

      end

      after(:all) do
        ServiceType.all.each { |item| item.destroy }
      end
    end


    context "availability" do

      before(:all) do
        @customer = create(:customer)
        @service_type = create(:service_type)
        @service = create(:service, service_type_id: @service_type.id)
        @service_with_bookings = create(:service, service_type_id: @service_type.id)
        reservation = create(:reservation, service_id: @service_with_bookings.id, customer_id: @customer.id)
        create(:time_slot, reservation_id: reservation.id, service_id: @service_with_bookings.id)
      end

      describe "get booked_slots" do

        it "Shows that there are no bookings on the Service 1" do
          req = {service: {:service_id => @service.id, }}
          get :booked_slots,  req, use_route: :stamp
          expect(response.status).to eq(200)
          expect(response.body).to eq("{}")
        end

        it "Shows that there are bookings on the service 2" do
          get :booked_slots, :service_id => @service_with_bookings.id,
              from:'2013/01/01 00:00:00',to:'2015/01/01 00:00:00', use_route: :stamp
          expect(response.status).to eq(200)
          expect(response.body).to eq("{\"booked_slots\":{\"2014-01-01\":[{\"start\":\"2014-01-01T10:00:00.000Z\",\"end\":\"2014-01-01T10:30:00.000Z\"}]}}")
        end

      end

      after(:all) do
        TimeSlot.all.each { |item| item.destroy }
        Reservation.all.each { |item| item.destroy }
        Service.all.each { |item| item.destroy }
        ServiceType.all.each { |item| item.destroy }
      end
    end

  end
end
