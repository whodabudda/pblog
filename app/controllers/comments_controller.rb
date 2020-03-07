class CommentsController < ApplicationController
  before_action :log_action, :set_delivery_method
  before_action :set_comment, only: [:show, :edit, :update, :destroy,:new_comment,:change_status, :show_admin]
  before_action :authenticate_admin! , only: [:show_admin]
  #when admins access the site without being logged into their user account,
  #don't validate the user. The admin may want to change the status of a comment,
  #so should be allowed access.  The admin cannot change the content of the comment.
  skip_before_action :authenticate_user! ,only: [:edit]
  def index
    @comments = Comment.all.order(created_at DESC)
  end

  def show_admin
    if admin_signed_in?
      session[:current_admin_id] = current_admin.id
      render :show
    else
      redirect_to root_path
    end
  end
  def show
    @comment
  end

  def new
    @comment = Comment.new
    @comment.commentable_id = params[:commentable_content_id]
    #@comment.commentable_type = CommentableContent.find(params[:commentable_content_id]).type
    #@type = @comment.commentable_type
    #render :layout => false
  end

  #
  #generally called as JS
  #
  def edit
    @comment
   # @type = params[:commentable_type]
  end

  #
  #New comment will send a confirmation mailer to the user, and an email to all admins to 
  #notify them of the new comment for review.
  #
  def create
    @comment = Comment.new(comment_params)
    @user = User.find(@comment.user_id)
    respond_to do |format|
      if @comment.save
        UserMailer.with(user: @user,comment: @comment).new_comment.public_send(@delivery_method)
        AdminMailer.with(user: @user,comment: @comment).new_comment.public_send(@delivery_method)
        #AdminMailer.(with(user: @user,comment: @comment).notify_all_admins("Comment was Saved","New Comment Notification").deliver_later
        format.html {redirect_to welcome_home_path, notice: "Comment was successfully saved"}
        format.json { render :show, status: :created, location: @comment}
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # We don't allow Admins to update a comment, only to change_status, therefore the reviewed_by field
  # will not be changed in the update method.
  #
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        @user = User.find(@comment.user_id)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # Only an Admin can change status.
  # If the current admin is not the same as the previous admin, send a message to the old admin.
  #
  def change_status
   # Rails.logger.info "change_status review_status: " +   params.dig(:comment,:review_status) 
   # Rails.logger.info "change_status reviewed_by: " +  params[:reviewed_by] 
   # @comment.reviewed_by = params[:reviewed_by]
   # @comment.review_status = params.dig[:comment,:review_status]
    respond_to do |format|
      if @comment.update(:review_status => params.dig(:comment,:review_status), :reviewed_by => params[:reviewed_by])
        @user = User.find(@comment.user_id)
        #in the ActiveRecord::Dirty module, saved_change_to<attribute name> returns an array 
        #of [old_value, new_value]. Get the old value of reviewed_by to send a reassigned email to
        #Don't send the email if the old value was nil because that means it is the first assignment
        send_reassign = false
        if @comment.saved_change_to_reviewed_by? and !@comment.saved_change_to_reviewed_by[0].nil?
          @admin = Admin.find(@comment.saved_change_to_reviewed_by[0])
          send_reassign = true
        else
          @admin = Admin.find(@comment.reviewed_by)
        end
        Rails.logger.info "change to: status, #{@comment.saved_change_to_review_status?} reviewed_by, #{@comment.saved_change_to_reviewed_by?}   "
        AdminMailer.with(user: @user,comment: @comment,admin: @admin).comment_reassigned.public_send(@delivery_method) if send_reassign
        UserMailer.with(user: @user,comment: @comment).comment_status_change.public_send(@delivery_method) if @comment.saved_change_to_review_status?
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comment_url, notice: 'Comment content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
def new_comment
   respond_to do |format|
     format.js
   end
#  render layout: 'modal'
end
  private
    #deliver_now is good for development, where deliver_later might fail (see rails doc)
    #This creates some discomfort in that behaviour can be different between environments
    def set_delivery_method
        @delivery_method = Rails.env == "production" ? 'deliver_later' : 'deliver_now'
    end
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {}).permit(:id,:comment_text,:commentable_content_id,:commentable_id,:user_id,:review_status, :reviewed_by)
    end
    def comment_status_params
      params.permit( :review_status, :reviewed_by )
    end

   def log_action
   # Rails.logger.info "in: #{params[:controller]} : #{params[:action]}  for user: " + current_user.id.to_s
    Rails.logger.info "params are: #{params.inspect}"
    Rails.logger.info "keys are: #{params.keys()} and reviewed_by is: #{params[:reviewed_by]}"
    Rails.logger.info "Custom Config is: #{config.mail_delivery_queue_option}"
  end

end
