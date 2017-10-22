Rails.application.routes.draw do
  get '/' => 'flags#index'
  get '/flags' => 'flags#index'
  patch '/flags/:id' => 'flags#update'
  delete '/flags/:id' => 'flags#destroy'

  get '/users' => 'users#index'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'
  post '/users/edit' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/teams' => 'teams#index'
  get '/teams/:id' => 'teams#show'

  post '/messages' => 'messages#create'

  post '/stuns' => 'stuns#create'
end
