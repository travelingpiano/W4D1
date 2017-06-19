Rails.application.routes.draw do
  resources :users, only: [:index, :update, :create, :destroy, :show]
  resources :artworks, only: [:index, :update, :create, :destroy, :show]
end
