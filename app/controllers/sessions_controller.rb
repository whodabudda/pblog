class SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
 prepend_before_action :log_info, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     super
     Analytics.alias(previous_id: session.id ,user_id: current_user.id )
     Analytics.identify(user_id: current_user.id )
     #return redirect_to after_sign_in_path_for(params[:user])
   end
  #sessions_controller.rb

  # DELETE /resource/sign_out
   def destroy
    if admin_signed_in?
      session[:current_admin_id] = 0
      super
    else
      session[:current_admin_id] = -2
      super
      reset_session
    end
    Rails.logger.info "After Delete Session, current_admin_id is: #{ session[:current_admin_id] }  and Session id is: #{session.id}"
   end

#  def after_sign_in_path_for(resource)
#    Rails.logger.info "in: #{params[:controller]} : #{params[:action]} returning #{request.headers['origin']}" 
#    request.headers['origin'] 
#  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def log_info
    Rails.logger.info "In the log_info action"
     Rails.logger.info "#{request.headers.env.reject { |key| key.to_s.include?('.')} } "
  end
end
