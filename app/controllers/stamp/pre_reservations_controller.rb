require_dependency "stamp/application_controller"

module Stamp
  class PreReservationsController < Stamp::ApiController
    respond_to :json

    def index
      #TODO search with params
      @pre_reservations = PreReservation.all

      respond_to do |format|
        format.html { render :index , layout: false}
        format.json { render json: @pre_reservations }
      end
    end

    def new

      @service = Service.find(params["service_id"])
      @pre_reservation = @service.stamp_pre_reservations.new

      respond_to do |format|
        format.html { render "new", layout: false }
      end
    end

    def create

       @service = Service.find(params["service_id"])
       @pre_reservation = @service.stamp_pre_reservations.new(pre_reservation_params)

      respond_to do |format|
        if @pre_reservation.save
          format.html { redirect_to( service_pre_reservation_path(@service, @pre_reservation), :notice => 'Pre reservation was successfully created.') }
          format.json  { render json: {service: @pre_reservation } }
        else
          format.html { render :action => "new" }
          format.json  { render :json => { :errors => @pre_reservation.errors.full_messages }, :status => 422 }
        end
      end

    end

    def update

      @service = Service.find(params["service_id"])
      @pre_reservation = PreReservation.find(params["id"])

      #load_resource
      respond_to do |format|
         if @pre_reservation.update_attributes(pre_reservation_params)
          format.html { render "show" }
          format.json { render json: @pre_reservation }
         else
          format.html { render "edit", layout: false }
          format.json { render json: @pre_reservation.errors }
         end
      end
    end

    def edit
      @pre_reservation = PreReservation.find(params["id"])
      @service = @pre_reservation.stamp_service
    end

    def show
      @pre_reservation = PreReservation.find(params["id"])

      respond_to do |format|
        format.html { render "show" }
        format.json { render json: @pre_reservation }
      end
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
