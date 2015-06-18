Rails.application.routes.draw do
  root to: "home#index"
  devise_for :usuarios

  resources :usuarios, only: [:edit,:update]

  resources :permissoes, only: [:create]
  
  namespace :api do
    resources :cidades, only: [] do
      collection do
        get 'busca'
      end
    end
  end
end