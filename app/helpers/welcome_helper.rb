module WelcomeHelper
	def session_message
		@log_str = ""
		
		if user_signed_in? and ! admin_signed_in?
		  @log_str = 'Welcome User: '.concat current_user.email.to_str 
		elsif admin_signed_in?
		  @log_str = 'Welcome Admin: '.concat current_admin.email.to_str 
		else
		  @log_str = link_to('Please Sign-Up or sign-In', new_user_session_path, class: "nav-link")
		end
		return raw '<span class="navbar-text log-message pull-right" >' + @log_str + '</span>'
    end

    def check_admin
      my_debug("in check_admin helper")
      if user_signed_in? 
    	  @admin = Admin.find_by(email:  current_user.email) 
      	if ! @admin.nil?
          my_debug("check_admin found admin #{@admin}" )
      		if admin_signed_in? 
      		 session[:current_admin_id] = @admin.id 
	    	  else
      		 session[:current_admin_id] = 0
	      	end
	      else
      		 session[:current_admin_id] = -1
      	end
      else	
      	my_debug("no current_user signed in when checking for admin")
      end
	  end

    def admin_on?
    	my_debug("in admin_on? helper: user_signed_in " + (user_signed_in? ? "true" : "false"))
    	my_debug("in admin_on? helper: current_admin_id is " + session[:current_admin_id].to_s )
 		  if  user_signed_in? and session[:current_admin_id] > 0
 		    return true
 		   end
 		  return false
    end

    def admin_need_login?
		  return true if user_signed_in? and ! admin_signed_in? and session[:current_admin_id] == 0
 	    return false
 	end
   def link_to_if_with_block condition, options, html_options={}, &block
     if condition
       link_to options, html_options, &block
     else
       capture &block
     end
   end
end
