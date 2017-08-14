class WelcomeController < ApplicationController
  def home
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
end
