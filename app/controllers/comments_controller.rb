class CommentsController < ApplicationController
  before_action :log_action
  before_action :set_comment, only: [:show, :edit, :update, :destroy,:new_comment,:change_status]
  skip_before_action :authenticate_admin!
  def index
    @comments = Comment.all.order(created_at DESC)
  end

  def show
    @comment
  end

  def new
    @comment = Comment.new
    @comment.commentable_id = params[:commentable_content_id]
    @comment.commentable_type = CommentableContent.find(params[:commentable_content_id]).type
    @type = @comment.commentable_type
    #render :layout => false
  end

  def edit
    @comment
    @type = params[:commentable_type]
    #render :layout => false
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        AdminEventMailer.notify_all_admins("Comment was Saved","New Comment Notification").deliver_later
        format.html {redirect_to welcome_home_path, notice: "Comment was successfully saved"}
        format.json { render :show, status: :created, location: @comment}
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  def change_status
    respond_to do |format|
      if @comment.update(comment_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {}).permit(:id,:comment_text,:commentable_content_id,:commentable_id,:user_id, :commentable_type,:review_status)
    end

   def log_action
    Rails.logger.info "in: #{params[:controller]} : #{params[:action]}  for user: " + current_user.id.to_s
    Rails.logger.info "params are: #{params.inspect}"
  end

end
