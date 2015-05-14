Rails.application.routes.draw do

  match '/admin', to: 'admin#index', as: 'admin', via: 'get'
  match '/login', to: 'sessions#new', as: 'login',  via: 'get'
  match '/signup', to: 'users#new', via: 'get'

  match '/signout', to: 'sessions#destroy', via: 'delete'
  post 'sessions/create'

  resources :users

  
  resources :products do
    get :who_bought, on: :member
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  scope '(:locale)' do
    resources :line_items do
      post :increment, on: :member
      post :decrement, on: :member
    end

    resources :carts

    resources :orders do
      post :ship, on: :member
    end
    root 'store#index'
    root 'store#index', as: 'store',via: 'all'
  end
end
