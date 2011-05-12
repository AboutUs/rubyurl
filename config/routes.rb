Rubyurl::Application.routes.draw do
  match '' => 'links#index'
  match 'rubyurl/remote' => 'links#create'
  match 'about' => 'links#about'
  match 'api' => 'links#api'
  match 'report-abuse' => 'links#report'
  match 'home' => 'links#home'
  resources :links
  match '/:controller(/:action(/:id))'
  match ':token' => 'links#redirect'
end
