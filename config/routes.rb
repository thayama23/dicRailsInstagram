Rails.application.routes.draw do

  resources :blogs, only:[:new, :edit, :destroy, :index, :show]

  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
end
