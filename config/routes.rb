Rails.application.routes.draw do
  get '/', to: 'top#index'


  get '/s/:prefecture', to: 'search#cities'
  get '/s/:prefecture/:city', to: 'search#restaurants'
  get '/suggest', to: 'search#suggest'

  get '/admin', to: 'admin#index'
end
