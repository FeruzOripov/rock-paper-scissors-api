Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/choices', to: 'choices#index'
  get '/get-result', to: 'choices#result'
end
