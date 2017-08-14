class UtilsController < ApplicationController

  def toggleAdmin
      if params[:setting] == "true"
       		 session[:current_admin_id] = current_admin.id 
   		else
       		 session[:current_admin_id] = 0
  		end 
      redirect_to root_url
  end
  def util_params
      params.permit(:setting)
  end
  def toggleRantsOnly
    if @rants_only
      @rants_only = false
    else
      @rants_only = true
    end
    redirect_to root_url
  end
end