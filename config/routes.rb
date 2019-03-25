Rails.application.routes.draw do
  devise_for :users
  resources :posts, :only => [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :welcome, :only => [:index]
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
