Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/decks', to: 'decks#index', defaults: { format: 'json' }
  get '/decks/generate', to: 'decks#generate', defaults: { format: 'json' }
  get '/decks/generate/:type', to: 'decks#generate', defaults: { format: 'json' }
  get '/decks/:uuid', to: 'decks#show', defaults: { format: 'json' }

end
