Password::Application.routes.draw do
  root "sites#index"
  get "home" => "sites#home", as: 'home'
  get "dashboard" => "sites#dashboard", as: 'dashboard'
  get "tiles" => "sites#tiles", as: 'tiles'
  get "edit_tile" => "sites#edit_tile", as: 'edit_tile'
  post "create_tile" => "sites#create_tile", as: 'create_tile'
  delete "delete_tile" => "sites#delete_tile", as: 'delete_tile'
  patch "update_tile" => "sites#update_tile", as: 'update_tile'

  # get "sessions/new" => "sessions#new", as: 'new_session'
  post "sessions" => "sessions#create", as: 'sessions'
  delete "sessions" => "sessions#destroy", as: 'session'

  resources :sites
  resources :users
  resources :password_resets

  get '/googlea9629a76ce818cac.html', :to => proc { |env| [200, {}, ["google-site-verification: googlea9629a76ce818cac.html"]] }

  # get "json" => "sites#json", as: 'json'

# Create
#   get "sites/new" => "sites#new"
#   post "sites" => "sites#create"

# #Read
#   get "sites" => "sites#index"
#   get "sites/:id" => "sites#show"

# #Update
#   get "sites/:id/edit" => "sites#edit"
#   patch "sites/:id" => "site#update"

# #Delete
#   delete "sites/:id" => "sites#destroy"

end
