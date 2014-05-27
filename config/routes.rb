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
    resources :buys do
      resources :buy_products do
        collection do
          get :find_product
        end 
      end
      collection do
        get :find_supplier
      end
      member do
        get :print_show
      end
    end
    resources :sells do
      resources :sell_products do
        collection do
          get :find_product
        end 
      end
      collection do
        get :find_customer
      end
      member do
        get :print_show
      end
    end
  end

    
  get 'mytp_welcome' => "mytp/home#welcome"

end
