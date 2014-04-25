require_dependency "stamp/application_controller"

module Stamp
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]
    before_action :set_service

    def index
      respond_to do |format|
        format.html
        format.json { render json: ReservationsDatatable.new(view_context) }
      end
    end

    def show
      @reservation = Reservation.find(params[:id])
    end

    def new
      @reservation = @service.stamp_reservations.build
    end

    def edit
      @reservation = Reservation.find(params[:id])
    end

    def create
      @reservation = @service.stamp_reservations.build(reservation_params)

      if @reservation.save
        redirect_to [@service, @reservation], :notice => 'Reservation was successfully created.'
      else
        render :action => "new"
      end
    end

    def update
      @reservation = Reservation.find(params[:id])

      if @reservation.update_attributes(reservation_params)
        redirect_to [@service, @reservation], :notice => 'Reservation was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @reservation.destroy

      redirect_to [@service, @reservation], notice: 'Reservation was successfully destroyed.'
    end

    private #--------------------------------------private

     # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_service
      @service = Service.find(params[:service_id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation).permit(:customer_id, :service_id, :total_price)
    end

  end

end
