Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#main'
  
  namespace :api do
    namespace :v1 do
      resources :ideas
      put '/ideas/toggle/:id', to: 'ideas#toggle'
    end   
  end
  
end
