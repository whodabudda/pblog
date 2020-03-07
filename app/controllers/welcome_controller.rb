class WelcomeController < ApplicationController
  def home
    if session[:local_dttm_tz].nil? 
      if params[:local_dttm].nil?
        render :home_local_dttm
      else
        set_local_session_tz
      end
    end
  	@commentable_contents = CommentableContent.all
  end

  def about
  end

  def doc
  end
  def toggleRantsOnly
  	if session[:rants_only] == true
   		 session[:rants_only] = false 
	else
         session[:rants_only] = true
	end 
  	redirect_back(fallback_location: root_path)
  end
  def myCommentsOnly
    if session[:mycomments_only] == true
       session[:mycomments_only] = false 
  else
         session[:mycomments_only] = true
  end 
    redirect_back(fallback_location: root_path)
  end
  def filtersOff
    session[:rants_only] = false 
    session[:mycomments_only] = false 
    redirect_back(fallback_location: root_path)
  end
   def set_local_session_tz
    Rails.logger.info "WelcomeController:set_local_session_tz before session size " + session.to_hash.delete_if { |k,v| v.nil? }.to_s.bytesize.to_s
    local_dttm = DateTime.parse(params[:local_dttm])
    session[:local_dttm_tz] = Time.find_zone!(local_dttm.utc_offset.seconds).name
    Rails.logger.info "WelcomeController:set_local_session_tz  " + session.to_hash.to_s
    Rails.logger.info "WelcomeController:set_local_session_tz after session size " + session.to_hash.delete_if { |k,v| v.nil? }.to_s.bytesize.to_s
  end
end
