Rails.application.routes.draw do
  post '/s/new', to: 'link#new'
  get '/:slug', to: 'link#show', as: :short
end
