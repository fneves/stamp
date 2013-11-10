Stamp::Engine.routes.draw do

  get 'availability/:id', to: 'reservations#availability', as: 'availability'
  post 'book', to: 'reservation#book', as: 'book'
  post 'payment', to: 'reservation#pay', as: 'payment'
  get 'invoice/:id', to: 'reservation#confirm', as: 'invoice'

end
