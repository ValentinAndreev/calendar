Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :events do
    collection do
      get 'my'
      get 'list'
    end
    get 'date', on: :collection
  end
end
