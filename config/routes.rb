Rails.application.routes.draw do
  get 'coolpay/login', to: 'coolpay#login', as: 'login'
  get 'coolpay/list', to: 'coolpay#list', as: 'list'
  post 'coolpay/add', to: 'coolpay#add', as: 'add'
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
