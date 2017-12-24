Rails.application.routes.draw do
  get 'welcome/home'

  get 'welcome/about'

  get 'welcome/doc'

  get 'utils/toggleAdmin'
  get 'utils/toggleRantsOnly'
  get 'utils/modal_image_resize'
  get 'welcome/toggleRantsOnly'
  get 'welcome/myCommentsOnly'
  get 'welcome/filtersOff'

  get 'commentable_contents/show_by_type'
  get 'commentable_contents/show_by_id'
  get "comments/new_comment/:id" => 'comments#new_comment', :as => :new_comment
  get "comments/change_status/:id" => 'comments#change_status', :as => :change_status
  resources :comment_reviews
  resources :comments
  resources :commentable_contents do
  	resource :comments
  end
  
  resources :rogues, controller: 'commentable_contents', type: 'Rogue' 
  resources :current_events , controller: 'commentable_contents', type: 'CurrentEvent' 
  resources :truth_in_media , controller: 'commentable_contents', type: 'TruthInMedia' 
 # get :currentevent , controller: 'commentable_contents', action: 'create', type: 'CurrentEvent' 
  devise_for :users, :controllers => { :sessions => "sessions" } # etc
  devise_for :admins, :controllers => { :sessions => "sessions" } # etc
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
end
