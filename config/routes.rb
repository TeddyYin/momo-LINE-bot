Rails.application.routes.draw do
  devise_for :users
  resources :keyword_mappings
  resources :push_messages, only: [:new, :create]
  get '/gui/eat', to: 'gui#eat'
  get '/gui/request_headers', to: 'gui#request_headers'
  get '/gui/request_body', to: 'gui#request_body'
  get '/gui/response_headers', to: 'gui#response_headers'
  get '/gui/response_body', to: 'gui#show_response_body'

  get '/gui/sent_request', to: 'gui#sent_request'
  post '/gui/webhook', to: 'gui#webhook'
end
