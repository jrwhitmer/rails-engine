Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :items, only: [:create, :update]
      get 'items/find', to: 'items#find'
      resources :merchants, only: :show
    end
  end
end
