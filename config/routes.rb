Password::Application.routes.draw do
  root "sessions#new"

  get "sessions/new" => "sessions#new", as: 'new_session'
  post "sessions" => "sessions#create", as: 'sessions'
  delete "sessions" => "sessions#destroy", as: 'session'

  resources :sites
  resources :users

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
