Rails.application.routes.draw do
  get '/' => 'flags#index'
  get '/flags' => 'flags#index'

  get '/users' => 'users#index'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/teams' => 'teams#index'
  get '/teams/:id' => 'teams#show'

  post '/messages' => 'messages#create'
end
