Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#main'
  
  namespace :api do
    namespace :v1 do
      resources :tasks
      put '/tasks/toggle/:id', to: 'tasks#toggle', as: 'task_toggle'
    end   
  end
  
end