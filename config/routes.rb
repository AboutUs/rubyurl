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
  match 'home' => 'links#home'
  match ':token' => 'links#redirect'
  match '/:controller(/:action)'
end
