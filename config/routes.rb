Rails.application.routes.draw do
  get '/', to: 'top#index'
  get '/admin', to: 'admin#index'
end
