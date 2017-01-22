Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  get 'comments/show'

  get 'comments/destroy'

  get 'comments/edit'

  get 'comments/index'

  get 'welcome/home'

  get 'welcome/about'

  get 'welcome/doc'

  get 'utils/toggleAdmin'

  resources :commentable_contents do
  	resource :comments
  end
  
  resources :rogues, controller: 'commentable_contents', type: 'Rogue' 

  resources :current_events , controller: 'commentable_contents', type: 'CurrentEvent' 
  resources :truth_in_media , controller: 'commentable_contents', type: 'TruthInMedia' 
 # get :currentevent , controller: 'commentable_contents', action: 'create', type: 'CurrentEvent' 
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
end
