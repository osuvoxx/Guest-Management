Rails.application.routes.draw do
  resources :users do 
    collection do
      get"home"
      get"ajaxshow"
      get"showmeeting"
    end
  end
  resources :guests do 
    collection do
      get"meeting"
    end
  end
  root"users#index"
  resources :mettings
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
