require 'spec_helper'

module Stamp
  describe Api::V1::ReservationsController do

    before(:all) do
      @customer = create(:customer)
      @service_type = create(:service_type)
      @service = create(:service, service_type_id: @service_type.id)
    end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, use_route: :stamp
      
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "assigns @reservations" do
      reservation1 = create(:reservation, service_id: @service.id, customer_id: @customer.id)
      get :index, use_route: :stamp
      expect(assigns(:reservations)).to eq([reservation1])
      expect(response.status).to eq(200)
    end

  end

  describe "GET #show" do 
    it "assigns the requested reservation to @reservation" do 
      reservation = create(:reservation)
      req = { id: reservation.id}

      get :show, use_route: :stamp, reservation: req
      assigns(:reservation).should eq(reservation)
      expect(response.status).to eq(200)
    end 
  end 

  describe "POST #create" do

    context "with valid attributes" do
      it "creates a reservation" do
        n_reservations = Reservation.all.size
        
        create(:reservation)

        expect(response.status).to eq(200)
        assert_equal n_reservations+1, Reservation.count
      end
    end

    context "with invalid attributes" do
      it "does not save the new reservation" do
        reservation = build(:invalid_reservation)

        reservation.should_not be_valid
      end
    end

  end

  describe 'PUT #update' do
    before :each do
      @reservation = create(:reservation) 
    end 

    context "valid attributes" do
      it "located the requested @reservation1" do 

        put :update, use_route: :stamp, reservation: @reservation.attributes

        assigns(:reservation).should eq(@reservation)
        expect(response.status).to eq(200)
      end
    

      it "changes @reservation's attributes" do 
        req = attributes_for(:reservation, total_price: 155.5, id: @reservation.id)

        put :update, use_route: :stamp,  reservation:  req

        @reservation.reload 
        @reservation.total_price.to_s.should eq("155.5")
        expect(response.status).to eq(200)
      end

    end

    context "invalid attributes" do 

      it "does not change @reservation's attributes" do 
        req = attributes_for(:reservation, total_price: nil, id: @reservation.id)
        
        put :update, use_route: :stamp, reservation: req 

        @reservation.reload 
        @reservation.total_price.should_not eq("155")
        expect(response.status).to eq(200)
      end 
    end
    
  end

  describe 'DELETE destroy' do
    before :each do
      @reservation = create(:reservation) 
    end

    it "deletes the contact" do
      expect{
        req = { id: @reservation.id}
        delete :destroy, use_route: :stamp, reservation: req
      }.to change(Reservation,:count).by(-1)
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
