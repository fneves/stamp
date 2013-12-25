require_dependency "stamp/application_controller"

module Stamp
  module Api
    module V1
      class ServicesController < Stamp::ApiController
        include Stamp::Api::V1::ApiInputValidations
        #include Stamp::ServicesSupport

        before_action :set_service , only: [:availability, :booked_slots, :destroy, :update]

        def availability
          return render( json: 'Service was not found! Please select a valid service', status: 400) unless @service
          valid, validation_message = validate_date_interval(params[:from_date], params[:from_date])
          return render(json: { error: validation_message }, status: 400) unless valid
          @service.availability(params[:from_date], params[:from_date])
        end

        def booked_slots
          return render( json: 'Service was not found! Please select a valid service', status: 400) unless @service
          valid, validation_message = validate_date_interval(params[:from], params[:to])
          return render(json: { error: validation_message }, status: 400) unless valid
          @service.availability(params[:from], params[:to])
        end

        def create
          @service = Service.new(service_params)
          if @service.save
            render(json: {service: @service})
          else
            render :json => { :errors => @service.errors.full_messages }, :status => 422
          end
        end

        def destroy
           if @service.destroy
           else
           end
        end

        def update

        end

        private

        def set_service
          @service = Service.find_by_id(service_params[:service_id])
        end

        def service_params
          params.require(:service).permit(:service_id,:name, :opening_hours, :closing_hours, :external_id, :period_size,
                                          :service_type_id, :price_ratings, :owner_id)
        end

      end
    end
  end
end
