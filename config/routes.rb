Rails.application.routes.draw do
  resources :movie_search, only: %w[index show]
  resources :users, only: %w[create]
  resource :auth, only: %w[create]
end
