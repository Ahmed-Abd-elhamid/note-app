Rails.application.routes.draw do
  resources :collaborations, only: [:index, :show, :new, :create, :edit, :update]
  resources :notes
  devise_for :users

  root 'welcome#index'
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
