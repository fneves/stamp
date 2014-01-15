require_dependency "stamp/application_controller"

module Stamp
  module Api
    module V1
      class ReservationsController < Stamp::ApiController
        respond_to :json

        def index

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
          respond_to do |format|
             if @reservation.update_attributes(reservation_params)
               format.json { head :no_content }
             else
               format.json { render json: @reservation.errors }
             end
          end
        end

        def show
          respond_to do |format|
            format.json { render json: @reservation }
          end
        end

        def destroy
          #@reservation = Reservation.find(reservation_id_params)
          @reservation.destroy
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
        
        def reservation_params
          params.require(:reservation).permit(:from, :to, :service_id)
        end
        
        def reservation_id_params
          params.require(:reservation).permit(:id)
        end

      end
    end
  end

end
