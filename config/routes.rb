Rails.application.routes.draw do
  get 'coolpay/login', to: 'coolpay#login', as: 'login'
  get 'coolpay/list', to: 'coolpay#list', as: 'list'
  post 'coolpay/search', to: 'coolpay#search', as: 'search'
  post 'coolpay/add', to: 'coolpay#add', as: 'add'
  get 'coolpay/list_pay', to: 'coolpay#list_pay', as: 'list_pay'
  post 'coolpay/make_pay', to: 'coolpay#make_pay', as: 'make_pay'
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
