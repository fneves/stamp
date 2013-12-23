require 'test_helper'

module Stamp
  class Api::V1::ServicesControllerTest < ActionController::TestCase
    # test "the truth" do
    #   assert true
    # end

    test "Availability with non existing service" do
      get :availability, {service_id: "3", :use_route => :stamp}
      assert_response :success
    end

    test "Booked slots for a single day" do
      get :booked_slots, {service_id: "2", :use_route => :stamp}
      assert_response :success
    end

  end
end
