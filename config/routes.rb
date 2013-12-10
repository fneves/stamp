Stamp::Engine.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :services do

        get 'availability', to: 'services#availability', as: 'availability'
        get 'booked_slots', to: 'services#booked_slots', as: 'booked_slots'

        resource :reservations do
          get 'payment'
          post 'pay'
          get  'invoice'
        end

      end

    end
  end



end
