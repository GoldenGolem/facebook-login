Rails.application.routes.draw do
  get 'admin/index'
  get 'result/index'
  get 'main/index'
  get 'phone/index'
  post 'phone/save'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :templates
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'
  
end
