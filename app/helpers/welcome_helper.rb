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
      #admin is the top login.  If already signed in, can stop.
      if admin_signed_in?
        my_debug("Admin already signed in" )
        return
      end
      #admin is not signed in.  Check the next level, user.
      #If the current_admin_id is -1, means we've already done
      #this check and determined the user is not an admin.
      #It could also mean that a previous session did not clear
      #out properly.  Working on that bug.
      if user_signed_in? and session[:current_admin_id] == -1
        my_debug("User is not an admin" )
        return
      end
      #we don't know if the user is an admin, so if we have a user
      #go to the admin table and check if the user is also an admin.
      #In theory, this will only be done the first time a user logs in.
      if user_signed_in? 
    	  @admin = Admin.find_by(email:  current_user.email) 
      	if ! @admin.nil?
          my_debug("check_admin found admin #{@admin}" )
          #the user is an admin.  session variable is set to let the
          #system know the admin user is available to sign in, but not
          #yet toggled on. The session variable now acts as an indicator
          # nil == No user logged in.
          # -1  == not an admin
          #  0  == is an admin, but not toggled on
          # > 0 == is a toggled on admin
          #
          session[:current_admin_id] = 0
	      else
           my_debug("Setting session current_admin_id to -1" )
      		 session[:current_admin_id] = -1
      	end
      else	
      	my_debug("no current_user signed in when checking for admin")
      end
	  end

    def admin_on?
    	my_debug("in admin_on? helper: user_signed_in " + (user_signed_in? ? "true" : "false"))
    	my_debug("in admin_on? helper: current_admin_id is " + session[:current_admin_id].to_s )
 		  if  admin_signed_in? and session[:current_admin_id] > 0
        my_debug("admin_on? returning true ")
 		    return true
 		   end
      my_debug("admin_on? returning false ")
 		  return false
    end

    def admin_need_login?
      if user_signed_in? and session[:current_admin_id] == 0 and ! admin_signed_in?
        my_debug("admin_need_login? returning true ")
  		  return true 
      end
      my_debug("admin_need_login? returning false ")
 	    return false
 	end
  #link_to_if_with_block -- I found this but wound up not using it.  Kept it on in case
  # it comes in handy for something later.
  # from http://stackoverflow.com/questions/10305180/rails-how-can-i-show-a-block-with-or-without-a-link-based-on-a-condition-link
   def link_to_if_with_block condition, options, html_options={}, &block
     if condition
       link_to options, html_options, &block
     else
       capture &block
     end
   end
end
