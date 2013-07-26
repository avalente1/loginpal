Password::Application.routes.draw do
  root "sites#index"

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
