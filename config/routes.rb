Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :contacts do
    collection do
      post :import
    end
  end
  root 'welcome#index'
end
