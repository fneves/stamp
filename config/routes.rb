Stamp::Engine.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :services do

        get 'availability', to: 'services#availability', as: 'availability'

        resource :reservations do
          get 'payment'
          post 'pay'
          get  'invoice'
        end

      end

    end
  end



end
