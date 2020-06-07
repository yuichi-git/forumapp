Rails.application.routes.draw do
  get '/signup' => 'users#signup'
  get '/login' => 'users#login_form'
  post '/login' => 'users#login'
  post '/logout' => 'users#logout'
  post '/users/create' => 'users#create'
  get '/users/:id' => 'users#show'
  get '/users/:id/edit' => 'users#edit'
  post '/users/:id/update' => 'users#update'
  post '/users/:id/destroy' => 'users#destroy'

  get '/rooms/index' => 'rooms#index'
  get '/rooms/new' => 'rooms#new'
  post '/rooms/create' => 'rooms#create'
  post '/rooms/:id/destroy' => 'rooms#destroy'
  get '/rooms/:id' => 'rooms#show'

  post '/posts/:room_id/create' => 'posts#create'
  post '/posts/:id/destroy' => 'posts#destroy'

  get '/' => 'home#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
