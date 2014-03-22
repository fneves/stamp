require_dependency "stamp/application_controller"

module Stamp
  class ReservationsController < Stamp::ApiController
    respond_to :json

    def index
      #TODO search with params
      @reservations = Reservation.all

      respond_to do |format|
        format.html { render :index , layout: false}
        format.json { render json: @reservations }
      end
    end

    def new

      @service = Service.find(params["service_id"])
      @reservation = @service.stamp_reservations.new

      respond_to do |format|
        format.html { render "new", layout: false }
      end
    end

    def create
       @service = Service.find(params["service_id"])
       @reservation = @service.stamp_reservations.new(reservation_params)

      respond_to do |format|
        if @reservation.save
          format.html { redirect_to( service_reservation_path(@service, @reservation), :notice => 'Reservation was successfully created.') }
          format.json  { render json: {service: @reservation } }
        else
          format.html { render :action => "new" }
          format.json  { render :json => { :errors => @reservation.errors.full_messages }, :status => 422 }
        end
      end
    end

    def update
      @service = Service.find(params["service_id"])
      @reservation = Reservation.find(params["id"])

      #load_resource
      respond_to do |format|
         if @reservation.update_attributes(reservation_params)
          format.html { render "show" }
          format.json { render json: @reservation }
         else
          format.html { render "edit", layout: false }
          format.json { render json: @reservation.errors }
         end
      end
    end

    def edit
      @reservation = Reservation.find(params["id"])
      @service = @reservation.stamp_service
    end

    def show
      @reservation = Reservation.find(params["id"])

      respond_to do |format|
        format.html { render "show" }
        format.json { render json: @reservation }
      end
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
