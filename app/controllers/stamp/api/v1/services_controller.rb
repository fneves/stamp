require_dependency "stamp/application_controller"

module Stamp
  module Api
    module V1
      class ServicesController < ApplicationController
        include Stamp::Api::V1::ApiInputValidations

        def availability
          @service = Service.find_by_id(params[:service_id])
          puts @service
          return render( json: 'Service was not found! Please select a valid service', status: 400) unless @service
          valid, validation_message = validate_date_interval(params[:from_date], params[:from_date])
          return render(json: { error: validation_message }, status: 400) unless valid
          @service.availability(params[:from_date], params[:from_date])
        end

        def create

        end

        def destroy

        end

        def update

        end

        def index

        end
      end
    end
  end
end
