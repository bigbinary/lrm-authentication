LrmAuthentication::Application.routes.draw do

  get "home/index"
  root to: "home#index"

  devise_for :users

  namespace :api, path: "", defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post 'login' => 'sessions#create'
        delete 'logout' => 'sessions#destroy'
        post 'reset_password' => 'passwords#create'
      end
      resources :posts
    end
  end

end
