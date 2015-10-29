Rails.application.routes.draw do
  # Routes for RaroCrud
  get '/crud/:model' => "crud#index"
  get '/crud/:model/:id/edit' => "crud#edit"
  delete '/crud/:model/:id/destroy' => "crud#destroy"
  get '/crud/:model/new' => "crud#new"
  get '/crud/:model/query' => "crud#query"
  get '/crud/:model/autocomplete' => "crud#autocomplete"
  post '/crud/:model/create' => "crud#create"
  patch '/crud/:model/:id/create' => "crud#create"
  get '/crud/:model/:id/acao/:acao' => "crud#action"
  get '/crud/:model/:id' => "crud#show"

  #Routes for RaroCrud Associations
  get '/crud/:model/:id/:associacao' => "crud#index"
  get '/crud/:model/:id/:associacao/:associacao_id/edit' => "crud#edit"
  delete '/crud/:model/:id/:associacao/:associacao_id/destroy' => "crud#destroy"
  get '/crud/:model/:id/:associacao/new' => "crud#new"
  get '/crud/:model/:id/:associacao/query' => "crud#query"
  get '/crud/:model/:id/:associacao/autocomplete' => "crud#autocomplete"
  post '/crud/:model/:id/:associacao/create' => "crud#create"
  patch '/crud/:model/:id/:associacao/:associacao_id/create' => "crud#create"
  get '/crud/:model/:id/:associacao/:associacao_id/acao/:acao' => "crud#action"
  get '/crud/:model/:id/:associacao/:associacao_id' => "crud#show"
end
