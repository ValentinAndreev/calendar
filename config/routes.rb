Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :events do
    get 'my', on: :collection
  end
end
