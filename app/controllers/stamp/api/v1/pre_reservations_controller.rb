require_dependency "stamp/application_controller"

module Stamp
  module Api
    module V1
      class PreReservationsController < Stamp::ApiController
        respond_to :json

        def index
          #TODO search with params
          @pre_reservations = PreReservation.all
          render json: @pre_reservations
        end

        def create
           @pre_reservation = PreReservation.new(pre_reservation_params)
            
           if @pre_reservation.save
             render(json: {service: @pre_reservation })
           else
             render :json => { :errors => @pre_reservation.errors.full_messages }, :status => 422
           end
        end

        def update
          load_resource
           if @pre_reservation.update_attributes(pre_reservation_params)
             render json: @pre_reservation
           else
             render json: @pre_reservation.errors
           end
        end

        def show
          load_resource
          render json: @pre_reservation
        end

        def destroy
          load_resource
          @pre_reservation.destroy
        end

        def payment

        end

        def pay

        end

        protected #--------------------------------------protected

        def load_resource
            @pre_reservation = PreReservation.find(pre_reservation_id_params["id"])
        end

        private

        def availability_params
          params.require(:service).permit(:service_id, :from_date, :to_date)
        end

        def book_params
          params.require(:pre_reservation).permit(:from, :to, :service_id)
        end

        def pay_params
          params.require(:payment).permit(:cc_number, :cc_name, :cvc, :exp_month, :exp_year, :payment_gateway)
        end
        
        def pre_reservation_params
          params.require(:pre_reservation).permit(:customer_id, :service_id, :total_price)
        end
        
        def pre_reservation_id_params
          params.require(:pre_reservation).permit(:id)
        end

      end
    end
  end

end
