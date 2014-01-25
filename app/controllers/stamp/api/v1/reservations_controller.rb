require_dependency "stamp/application_controller"

module Stamp
  module Api
    module V1
      class ReservationsController < Stamp::ApiController
        respond_to :json

        def index
          #TODO search with params
          @reservations = Reservation.all
          render json: @reservations
        end

        def create
           @reservation = Reservation.new(reservation_params)
            
           if @reservation.save
             render(json: {service: @reservation })
           else
             render :json => { :errors => @reservation.errors.full_messages }, :status => 422
           end
        end

        def update
          load_resource
           if @reservation.update_attributes(reservation_params)
             render json: @reservation
           else
             render json: @reservation.errors
           end
        end

        def show
          load_resource
          render json: @reservation
        end

        def destroy
          load_resource
          @reservation.destroy
        end

        def payment

        end

        def pay

        end

        protected #--------------------------------------protected

        def load_resource
            @reservation = Reservation.find(reservation_id_params["id"])
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
        
        def reservation_params
          params.require(:reservation).permit(:customer_id, :service_id, :total_price)
        end
        
        def reservation_id_params
          params.require(:reservation).permit(:id)
        end

      end
    end
  end

end
