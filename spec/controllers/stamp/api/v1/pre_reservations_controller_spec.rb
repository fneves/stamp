require 'spec_helper'

module Stamp
  describe Api::V1::PreReservationsController do

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

    it "assigns @pre_reservations" do
      pre_reservation = create(:pre_reservation)
      get :index, use_route: :stamp
      expect(assigns(:pre_reservations)).to eq([pre_reservation])
      expect(response.status).to eq(200)
    end

  end

  describe "GET #show" do 
    it "assigns the requested pre reservation to @pre_reservation" do 
      pre_reservation = create(:pre_reservation)
      req = { id: pre_reservation.id}

      get :show, use_route: :stamp, pre_reservation: req
      assigns(:pre_reservation).should eq(pre_reservation)
      expect(response.status).to eq(200)
    end 
  end 

  describe "POST #create" do

    context "with valid attributes" do
      it "creates a pre reservation" do
        n_pre_reservations = PreReservation.all.size
        
        create(:pre_reservation)

        expect(response.status).to eq(200)
        assert_equal n_pre_reservations+1, PreReservation.count
      end
    end

    context "with invalid attributes" do
      it "does not save the new pre reservation" do
        pre_reservation = build(:invalid_pre_reservation)

        pre_reservation.should_not be_valid
      end
    end

  end

  describe 'PUT #update' do
    before :each do
      @pre_reservation = create(:pre_reservation) 
    end 

    context "valid attributes" do
      it "located the requested @pre_reservation" do 

        put :update, use_route: :stamp, pre_reservation: @pre_reservation.attributes

        assigns(:pre_reservation).should eq(@pre_reservation)
        expect(response.status).to eq(200)
      end
    

      it "changes @pre_reservation's attributes" do 
        req = attributes_for(:pre_reservation, total_price: 155.5, id: @pre_reservation.id)

        put :update, use_route: :stamp, pre_reservation:  req

        @pre_reservation.reload 
        @pre_reservation.total_price.to_s.should eq("155.5")
        expect(response.status).to eq(200)
      end

    end

    context "invalid attributes" do 

      it "does not change @pre_reservation's attributes" do 
        req = attributes_for(:pre_reservation, total_price: nil, id: @pre_reservation.id)
        
        put :update, use_route: :stamp, pre_reservation: req 

        @pre_reservation.reload 
        @pre_reservation.total_price.should_not eq("155")
        expect(response.status).to eq(200)
      end 
    end
    
  end

  describe 'DELETE destroy' do
    before :each do
      @pre_reservation = create(:pre_reservation) 
    end

    it "deletes the contact" do
      expect{
        req = { id: @pre_reservation.id}
        delete :destroy, use_route: :stamp, pre_reservation: req
      }.to change(PreReservation,:count).by(-1)
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
