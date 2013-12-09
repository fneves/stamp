module Stamp
  module Api
    module V1
      module ApiInputValidations
        MAX_DATE_INTERVAL = 60

        def validate_date_interval(start_date, end_date)
          return false, 'start_date must be greater or equal than today' if start_date > Date.today
          return false, 'start_date must be greater the end date' if start_date > end_date
          return false, "date interval must be less than #{MAX_DATE_INTERVAL}" if start_date - end_date > MAX_DATE_INTERVAL;
          return true, 'interval is valid'
        end

      end
    end
  end

end
