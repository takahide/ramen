Rails.application.routes.draw do
  get '/', to: 'top#index'

  get '/suggest', to: 'search#suggest'

  get '/admin', to: 'admin#index'
end
