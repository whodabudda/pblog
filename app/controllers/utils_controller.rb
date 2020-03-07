class UtilsController < ApplicationController

  def toggleAdmin
      if params[:setting] == "true"
       		 session[:current_admin_id] = current_admin.id 
   		else
       		 session[:current_admin_id] = 0
  		end 
      redirect_back(fallback_location: root_path)
  end
  def util_params
      params.permit(:setting,:image_name,:local_dttm)
  end
  def toggleRantsOnly
    if @rants_only
      @rants_only = false
    else
      @rants_only = true
    end
    redirect_to (:back)
    #redirect_to root_url
  end
  def modal_image_resize
    @image_name = params[:image_name]
    @image_title = params[:image_title]
    respond_to do |format|               
     format.js
    end        
  end 
 end