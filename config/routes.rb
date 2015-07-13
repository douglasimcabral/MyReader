Rails.application.routes.draw do

  root :to => 'entries#index'

  resources :entries

  resources :feeds do
    member do
      get 'retrieve'
      post 'subscribe'
      post 'unsubscribe'
    end
  end

  mount SuperfeedrEngine::Engine => SuperfeedrEngine::Engine.base_path

end