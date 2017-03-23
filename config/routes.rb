Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'communes', to: 'communes#index'
  post 'communes', to: 'communes#create'
  get 'communes/:id', to: 'communes#show'
  put 'communes/:id', to: 'communes#update'
end
