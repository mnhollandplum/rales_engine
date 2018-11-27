Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
       resources :merchants, only: [:index, :show, :update]
    end
  end
end