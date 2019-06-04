Rails.application.routes.draw do
  resources :movie_search, only: %w[index show]
end
