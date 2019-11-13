class ApplicationController < ActionController::Base
  helper_method :toggleRantsOnly
  helper_method :user_signed_in?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters  , if: :devise_controller?
  devise_group :blogger, contains: [:user, :admin]
  before_action :authenticate_user! , only: [:new,:create,:edit,:destroy,:update]
  before_action :authenticate_admin! , only: [:new,:create,:edit,:destroy,:update]
  after_action :log_analytic_event , only: [:new,:create,:edit,:destroy,:update], if: :user_signed_in?
  before_action :persist_last_visited_path
  def log_analytic_event
    Analytics.track(user_id: current_user.id ,event: "#{params[:controller]} : #{params[:action]}" )
  end
  def configure_permitted_parameters

   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :avatar, :alias) } 
   devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email) }
   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :email, :password, :password_confirmation, :current_password, :avatar, :alias)}

  end
  def log_action
    Rails.logger.info "in: #{params[:controller]} : #{params[:action]}  for user: " + current_duser.id.to_s
    Rails.logger.info "params are: #{params.inspect}"
  end
  def show_args(*args)
    args.each do |arg_item|
      Rails.logger.info  arg_item.inspect
      Rails.logger.info  arg_item.class.inspect
    end
  end

  def after_sign_in_path_for(resource)
   Rails.logger.info "after_sign_in_path_for Session[last_visited_path] is: #{session[:last_visited_path]}" 
   if session[:last_visited_path].present?
    session[:last_visited_path]
   else
    root_path
   end
  end 

  #
  #ppk 09/09/2019 Devise will call this to find path to redirect to after sign in
  #

  private

 def persist_last_visited_path
  unless Rails.configuration.ignored_paths.include?(request.path) || request.xhr?
   session[:last_visited_path] = request.original_url
    Rails.logger.info "After Session[last_visited_path] is: #{session[:last_visited_path]}" 
    #Rails.logger.info "#{request.headers.env.reject { |key| key.to_s.include?('.')} } "
  end
 end

end
