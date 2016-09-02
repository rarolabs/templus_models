Rails.application.routes.draw do
  # Routes for RaroCrud
  get '/crud/:model' => "crud#index", as: :crud_models
  get '/crud/:model/:id/edit' => "crud#edit", as: :edit_crud
  delete '/crud/:model/:id/destroy' => "crud#destroy", as: :destroy_crud
  get '/crud/:model/new' => "crud#new", as: :new_crud
  get '/crud/:model/query' => "crud#query", as: :query_crud
  get '/crud/:model/autocomplete' => "crud#autocomplete", as: :autocomplete_crud
  post '/crud/:model/create' => "crud#create", as: :create_crud
  get '/crud/:model/listing' => "crud#listing", as: :listing_crud
  patch '/crud/:model/:id/create' => "crud#create", as: :update_crud
  get '/crud/:model/:id/acao/:acao' => "crud#action", as: :action_crud
  get '/crud/:model/:id' => "crud#show", as: :crud_model

  #Routes for RaroCrud Associations
  get '/crud/:model/:id/:associacao' => "crud#index", as: :crud_associacao_models
  get '/crud/:model/:id/:associacao/:associacao_id/edit' => "crud#edit", as: :edit_crud_associacao
  delete '/crud/:model/:id/:associacao/:associacao_id/destroy' => "crud#destroy", as: :destroy_crud_associacao
  get '/crud/:model/:id/:associacao/new' => "crud#new", as: :new_crud_associacao
  get '/crud/:model/:id/:associacao/query' => "crud#query", as: :query_crud_associacao
  get '/crud/:model/:id/:associacao/autocomplete' => "crud#autocomplete", as: :autocomplete_crud_associacao
  post '/crud/:model/:id/:associacao/create' => "crud#create", as: :create_crud_associacao
  get '/crud/:model/:id/:associacao/listing' => "crud#listing", as: :listing_crud_associacao
  patch '/crud/:model/:id/:associacao/:associacao_id/create' => "crud#create", as: :update_crud_associacao
  get '/crud/:model/:id/:associacao/:associacao_id/acao/:acao' => "crud#action", as: :action_crud_associacao
  get '/crud/:model/:id/:associacao/:associacao_id' => "crud#show", as: :crud_associacao_model
end