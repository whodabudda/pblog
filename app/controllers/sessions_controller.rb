class SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     super
     Analytics.alias(previous_id: cookies[:ajs_anonymous_id] ,user_id: current_user.id )
     Analytics.identify(user_id: current_user.id )
   end

  # DELETE /resource/sign_out
   def destroy
    Rails.logger.info "Before Session[current_admin_id] is: #{ session[:current_admin_id] } and Session id is: #{session.id} "
    if admin_signed_in?
      session[:current_admin_id] = 0
      super
    else
      session[:current_admin_id] = -2
      super
      reset_session
    end
    Rails.logger.info "After Session[current_admin_id] is: #{ session[:current_admin_id] }  and Session id is: #{session.id}"
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
