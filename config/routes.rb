Rails.application.routes.draw do
  get '/home/index'
  get '/home/categories'    
  get '/home/blogs/:id',  to: 'home#blogs'  
  get '/home/blog/:id',  to: 'home#blog'    
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: 'home#index'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
