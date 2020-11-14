Rails.application.routes.draw do
  get '/s/:slug', to: 'link#show', as: :short
  post '/s/new', to: 'link#new'
end
