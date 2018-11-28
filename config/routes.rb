Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
       resources :merchants, only: [:index, :show]
       resources :customers, only: [:index, :show]
    end
  end
end
