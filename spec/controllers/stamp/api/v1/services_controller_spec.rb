require 'spec_helper'

module Stamp
  describe Api::V1::ServicesController do

    before(:all) do
       @service_type = create(:service_type)
       @service_type2 = create(:service_type, name: 'Bakery')
    end

    describe "POST #create" do

      it "creates a service" do
        n_services = Service.all.size
        req = { name: 'Bakery 1', external_id:'external', opening_hours: '10:00',
                closing_hours: '24:00', period_size: 1.0, service_type_id: @service_type2.id, owner_id: 1}
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
        post :create , service: req, use_route: :stamp
        expect(response.status).to eq(422)
        assert_equal n_services, Service.count
      end

    end

    after(:all) do
      ServiceType.all.each { |item| item.destroy }
    end

  end
end
