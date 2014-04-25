Stamp::Engine.routes.draw do


  resources :credit_cards

  resources :services do

    get 'availability', to: 'services#availability', as: 'availability'
    get 'booked_slots', to: 'services#booked_slots', as: 'booked_slots'

    resources :reservations do
      get 'payment'
      post 'pay'
      get  'invoice'
    end

    resources :pre_reservations do
    end

  end


end
