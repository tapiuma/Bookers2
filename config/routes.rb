Rails.application.routes.draw do
  root to: 'home#top'
  get 'home/about'
  devise_for :users
  resources :books, only: [:new, :create, :index, :destroy, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :users, only: [:show, :index, :edit, :update]
end