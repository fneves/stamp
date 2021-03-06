require_dependency "stamp/application_controller"

module Stamp
  class ServicesController < Stamp::ApiController
    include Stamp::ApiInputValidations
    #include Stamp::ServicesSupport

    before_action :set_service , only: [:availability, :booked_slots, :destroy, :update]

    def availability
      parameters = availability_slots_params
      return render( json: 'Service was not found! Please select a valid service', status: 400) unless @service
      valid, validation_message = validate_date_interval(parameters[:from], parameters[:to])
      return render(json: { error: validation_message }, status: 400) unless valid
      availability = @service.availability(@from, @to)
      return render(json: { availability: availability }, status: 200)
    end

    def booked_slots
      parameters = availability_slots_params
      return render( json: 'Service was not found! Please select a valid service', status: 400) unless @service
      valid, validation_message = validate_date_interval(parameters[:from], parameters[:to])
      return render(json: { error: validation_message }, status: 400) unless valid
      slots = @service.booked_slots(@from, @to)
      return render(json: { booked_slots: slots }, status: 200)
    end

    def create
      @service = Service.new(service_params)
      if @service.save
        render(json: {service: @service })
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
      @service = Service.find_by_id(service_identifier_params[:service_id])
    end

    def service_params
      params.require(:service).permit(:service_id, :name, :opening_hours, :closing_hours, :external_id, :period_size,
                                      :service_type_id, :price_ratings, :owner_id, :payment_method)
    end

    def service_identifier_params
      params.permit(:service_id)
    end

    def availability_slots_params
      params.permit(:from, :to, :service_id)
    end

  end

end
