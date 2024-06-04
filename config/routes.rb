Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v0 do
      resources :plants, only: [:index, :create, :update]
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :habits do
          resources :progresses, only: [:show, :index, :update]
          resources :questions, only: [:create]
        end
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
  mount GoodJob::Engine => 'good_job'
end
