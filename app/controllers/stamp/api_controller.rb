require_dependency "stamp/application_controller"

module Stamp
  class Stamp::ApiController < ApplicationController
    rescue_from Exception, :with => :render_error


    def render_error(exception)
      return render json: exception
    end
  end
end
