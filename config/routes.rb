Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show]
      resources :invoice_items, only:[:index, :show]
      resources :invoices, only:[:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
        get '/customer', to: 'invoices/customer#show'
      end

      resources :items, only:[:index, :show]
      resources :transactions, only:[:index, :show]
      resources :merchants, only: [:index, :show] do
         get '/items', to: 'merchants/items#index'
         get '/invoices', to: 'merchants/invoices#index'
      end
       namespace :merchants do
         get '/most_revenue', to: 'most_revenue#index'
       end
    end
  end
end
