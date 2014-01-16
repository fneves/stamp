module Stamp
  module Api
    module V1
      module ApiInputValidations
        MAX_DATE_INTERVAL = 60

        def validate_date_interval(start_date, end_date)
          return false, 'please provide a start date and an end date' if start_date.nil? and end_date.nil?
          from = DateTime.parse(start_date)
          to = DateTime.parse(end_date)
          return false, 'start date must be greater or equal than today' if from > Date.today
          return false, 'end date must be greater the end date' if from >= to
          return false, "date interval must be less than #{MAX_DATE_INTERVAL}" if from - to > MAX_DATE_INTERVAL;
          return true, 'interval is valid'
        end

      end
    end
  end

end
