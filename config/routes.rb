Rails.application.routes.draw do
  get 'public_blugs/home'

  get 'public_blugs/index'

  get 'public_blugs/show'

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
