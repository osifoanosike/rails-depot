Rails.application.routes.draw do

  resources :orders do
    member do
      post 'ship'
    end
  end
  resources :line_items do
    member do
      post 'increment'
      post 'decrement'
    end
  end
  resources :carts
  resources :products do
    member do
        get 'who_bought'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'store#index', as: 'store'

  # match '404', to: 'store#index', via: 'all'
end
