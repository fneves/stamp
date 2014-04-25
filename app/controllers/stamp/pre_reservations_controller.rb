require_dependency "stamp/application_controller"

module Stamp
  class PreReservationsController < ApplicationController
    before_action :set_pre_reservation, only: [:show, :edit, :update, :destroy]
    before_action :set_service

    def index
      respond_to do |format|
        format.html
        format.json { render json: PreReservationsDatatable.new(view_context) }
      end
    end

    def show
      @pre_reservation = PreReservation.find(params[:id])
    end

    def new
      @pre_reservation = @service.stamp_pre_reservations.build
    end

    def edit
      @pre_reservation = PreReservation.find(params[:id])
    end

    def create
      @pre_reservation = @service.stamp_pre_reservations.build(pre_reservation_params)

      if @pre_reservation.save
        redirect_to [@service, @pre_reservation], :notice => 'Pre reservation was successfully created.'
      else
        render :action => "new"
      end
    end

    def update
      @pre_reservation = PreReservation.find(params[:id])

      if @pre_reservation.update_attributes(pre_reservation_params)
        redirect_to [@service, @pre_reservation], :notice => 'Pre reservation was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @pre_reservation.destroy

      redirect_to [@service, @pre_reservation], notice: 'Pre reservation was successfully destroyed.'
    end

    def payment

    end

    def pay

    end

    private #--------------------------------------private
      # Use callbacks to share common setup or constraints between actions.
      def set_pre_reservation
        @pre_reservation = PreReservation.find(params[:id])
      end

      def set_service
        @service = Service.find(params[:service_id])
      end

      # Only allow a trusted parameter "white list" through.
      def pre_reservation_params
        params.require(:pre_reservation).permit(:customer_id, :service_id, :total_price)
      end

  end

end