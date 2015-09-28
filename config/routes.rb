Rails.application.routes.draw do
  get '/', to: 'top#index'


  get '/p/:prefecture_id', to: 'search#cities'
  get '/suggest', to: 'search#suggest'

  get '/admin', to: 'admin#index'
end
