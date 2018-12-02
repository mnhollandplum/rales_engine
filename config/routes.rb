Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
      end
      resources :customers, only: [:index, :show] do
        get '/invoices', to: 'customers/invoices#index'
        get '/transactions', to: 'customers/transactions#index'
      end
      resources :invoice_items, only:[:index, :show] do
        get '/invoice', to: 'invoice_items/invoice#show'
        get '/item', to: 'invoice_items/item#show'
      end
      resources :invoices, only:[:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
        get '/customer', to: 'invoices/customer#show'
        get '/merchant', to: 'invoices/merchant#show'
      end

      resources :items, only:[:index, :show] do
        get '/invoice_items', to: 'items/invoice_items#index'
        get '/merchant', to: 'items/merchant#show'
      end
      resources :transactions, only:[:index, :show] do
        get '/invoice', to: 'transactions/invoice#show'
      end
      resources :merchants, only: [:index, :show] do
         get '/items', to: 'merchants/items#index'
         get '/invoices', to: 'merchants/invoices#index'
      end
    end
  end
end
