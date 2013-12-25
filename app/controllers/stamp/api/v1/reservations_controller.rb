require_dependency "stamp/application_controller"

module Stamp
  module Api
    module V1
      class ReservationsController < Stamp::ApiController
        respond_to :json

        def index

        end

        def create

        end

        def update

        end

        def show

        end

        def destroy

        end

        def payment

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
  end

end
