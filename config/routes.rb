Rails.application.routes.draw do
  # sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  # users
  namespace :admin do
    resources :users
  end

  get '/sign_up', to: 'admin/users#new'


  # posts
  root to: 'posts#index' #仮のトップページ
  resources :posts

end
