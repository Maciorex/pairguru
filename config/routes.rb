Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  get "commenters", to: "comments#commenters"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :movies, only: [:index, :show] do
    resources :comments
    resources :grades, only: [:create]
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
