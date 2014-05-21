# -*- encoding : utf-8 -*-

InvoicingSystem::Application.routes.draw do

  devise_for :users, controllers: {
    sessions: "user/sessions",
    registrations: "user/registrations"
  }
  devise_scope :user do
    root :to => 'user/sessions#new'
  end

  #后台
  namespace :mytp do
    resources :home, :only => [:index]
    resources :permissions
    resources :customers
    resources :suppliers
    resources :product_types
    resources :units
    resources :products
    resources :buys
  end

    
  get 'mytp_welcome' => "mytp/home#welcome"

end
