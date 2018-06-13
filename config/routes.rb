Rails.application.routes.draw do
  devise_for :users
  resources :keyword_mappings

  get '/', to: 'welcome#index'
  # resources :push_messages, only: [:new, :create]
  get 'push_messages/new', to: 'push_messages#new'
  post 'push_messages/new', to: 'push_messages#create'

  get '/gui/eat', to: 'gui#eat'
  get '/gui/request_headers', to: 'gui#request_headers'
  get '/gui/request_body', to: 'gui#request_body'
  get '/gui/response_headers', to: 'gui#response_headers'
  get '/gui/response_body', to: 'gui#show_response_body'

  get '/gui/sent_request', to: 'gui#sent_request'
  post '/gui/webhook', to: 'gui#webhook'

  get 'chat_content', to: 'chat_content#index'
  get 'chat_content/:id', to: 'chat_content#show', :as => 'chat_content_show'
end
