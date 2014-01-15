require 'spec_helper'

module Stamp
  describe Api::V1::ReservationsController do

    #before(:all) do
    #   @reservation_type = create(:reservation_customer)
    #end

    describe "POST #create" do

     it "creates a reservation" do
        n_reservations = Reservation.all.size
        req = { name: 'Bakery 1', external_id:'external', opening_hours: '10:00',
                closing_hours: '24:00', period_size: 1.0, reservation_type_id: @reservation_type.id, owner_id: 1}
        post :create , reservation: req, use_route: :stamp
        expect(response.status).to eq(200)
        assert_equal n_reservations+1, Reservation.count
      end

    end

    #after(:all) do
    #  ServiceType.all.each { |item| item.destroy }
    #end

  end
end
