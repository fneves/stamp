Stamp::Engine.routes.draw do


  resources :services do

    get 'availability', to: 'services#availability', as: 'availability'
    get 'booked_slots', to: 'services#booked_slots', as: 'booked_slots'

    resources :reservations do
      get 'payment'
      post 'pay'
      get  'invoice'
    end

    resources :pre_reservations do
      #match 'sss' => 'pre_reservation#create', :as => :service_pre_reservation_create, via: [:post]
      #post "/helpcenter" => "forums#create", :as => :create_forum
      #get '/services/:id', to: 'patients#show', as: 'patient'
    end

  end


end
