require_dependency "stamp/application_controller"

module Stamp
  class ReservationsController < ApplicationController

    def availability
      service = Service.find(params[:service_id])
      @booked_slots = service.booked_slots(params[:from_date], params[:from_date])
    end

    def book
    end

    def pay
    end

    private

    def availability_params
      params.require(:service).permit(:service_id, :from_date, :to_date)
    end

    def book_params
      params.require(:reservation).permit(:from, :to, :service_id)
    end

    def pay_params
      params.require(:payment).permit(:cc_number, :cc_name, :cvc, :exp_month, :exp_year, :payment_gateway)
    end

  end
end
