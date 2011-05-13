Rubyurl::Application.routes.draw do
  root :to => 'links#index'
  resources :links
  match 'rubyurl/remote' => 'links#create'
  match 'about' => 'links#about'
  match 'api' => 'links#api'
  match 'report-abuse' => 'links#report'
  match 'home' => 'links#home'
  match ':token' => 'links#redirect'
  match '/:controller(/:action)'
end
