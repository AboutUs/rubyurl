Rubyurl::Application.routes.draw do
  root :to => 'links#index'

  resources :links do
    collection do
      get :invalid
    end
  end

  match 'rubyurl/remote' => 'links#create'
  match 'about' => 'links#about'
  match 'api' => 'links#api'
  match 'report-abuse' => 'links#report'

  namespace :api do
    resources :links, :only => [:create]
  end

  match ':token' => 'links#show'
end
