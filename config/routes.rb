LrmAuthentication::Application.routes.draw do

  devise_for :users

  namespace :api, path: "", defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post 'login' => 'sessions#create'
        delete 'logout' => 'sessions#destroy'
      end
    end
  end

end
