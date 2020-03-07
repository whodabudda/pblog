Rails.application.routes.draw do
  get 'welcome/home'
  post 'welcome/home'

  get 'welcome/about'

  get 'welcome/doc'
  get 'welcome/cktest'

  get 'utils/toggleAdmin'
  get 'utils/toggleRantsOnly'
  get 'utils/modal_image_resize'
  get 'welcome/toggleRantsOnly'
  get 'welcome/myCommentsOnly'
  get 'welcome/filtersOff'
  get 'comments/show_admin'

#  get 'commentable_contents/show_by_type'
  get 'commentable_contents/show_by_id'
  get "comments/new_comment/:id" => 'comments#new_comment', :as => :new_comment
  get "comments/change_status/:id" => 'comments#change_status', :as => :change_status
  get "user_options/toggle_subscription/:id" => 'user_options#toggle_subscription', :as => :toggle_subscription
  get "user_options/toggle_email/:id" => 'user_options#toggle_email', :as => :toggle_email
  get "user_options/send_test_push_notification" => 'user_options#send_test_push_notification', :as => :send_test_push_notification
  get "user_options/send_test_email_notification" => 'user_options#send_test_email_notification', :as => :send_test_email_notification
  resources :comment_reviews
  resources :comments
  resources :commentable_contents do
  	resource :comments
  end
  resources :user_options
#  resources :rogues, controller: 'commentable_contents', type: 'Rogue' 
#  resources :current_events , controller: 'commentable_contents', type: 'CurrentEvent' 
#  resources :truth_in_media , controller: 'commentable_contents', type: 'TruthInMedia' 
 # get :currentevent , controller: 'commentable_contents', action: 'create', type: 'CurrentEvent' 
  devise_for :users, :controllers => { :sessions => "sessions" } # etc
  devise_for :admins, :controllers => { :sessions => "sessions" } # etc
#  devise_for :users, controllers: { passwords: 'passwords' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
end
