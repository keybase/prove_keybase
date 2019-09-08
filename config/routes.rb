ProveKeybase::Engine.routes.draw do
  get 'config', to: 'config#show'
  resources :proofs, only: [:new, :create]
  get 'api/v1/proofs', to: 'api_v1_proofs#show', as: :check_proof
end
