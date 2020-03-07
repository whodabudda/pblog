class CommentReviewsController < ApplicationController
  before_action :log_action
  before_action :get_reviews, only: [:index]
  before_action :get_review, only: [:show]
  skip_before_action :authenticate_admin!

  def new
    @comment_review = CommentReview.new
    @comment_review.comment_id = params[:comment_id]
  	@comment_id = params[:comment_id]
  end

  def create
     @comment_review = CommentReview.new(review_params)
     @comment = Comment.find(@comment_review.comment_id)
     @user = User.find(@comment.user_id)
     @cc = CommentableContent.find(@comment.commentable_id)
    respond_to do |format|
      if @comment_review.save!
        if @comment_review.admin_id.nil? or @comment_review.admin_id == 0
          if @comment.reviewed_by.nil?
             #
             #The submitter is NOT an admin, and no admin is assigned, so send request to all
             #Admins for one of them to take ownership,  i.e. treat it as a new comment
             #
             AdminMailer.with(user: @user,comment: @comment).new_comment.public_send(helpers.delivery_method)
          else
             #
             #The submitter is NOT an admin, But one IS assigned, so send notice to that admin 
             #
             @admin = Admin.find(@comment.reviewed_by)
             AdminMailer.with(comment_review: @comment_review,comment: @comment,admin: @admin,user: @user).new_comment_review.public_send(helpers.delivery_method)
          end
        else
          #
          #The submitter is an admin. Notify the user
          #
          @admin = Admin.find(@comment_review.admin_id)
          UserMailer.with(comment_review: @comment_review,admin: @admin, comment: @comment).new_comment_review.public_send(helpers.delivery_method)
        end
        format.html { redirect_to controller: "commentable_contents", title: @cc.title, action: "show_by_id", id: @cc.id , notice: 'Comment Review was successfully saved.' }
        format.json { render :show, status: :created, location: @comment_review}
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment_review.errors, status: :unprocessable_entity }
      end
    end
	
  end

  def index
  	@comment_reviews
  	@comment = Comment.find(params[:comment_id])
  end

  def show
  	@comment_review
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def get_reviews
      Rails.logger.info "in: #{params[:controller]} : get_reviews" 
      @comment_reviews = CommentReview.where('comment_id = ?', params[:comment_id])
      Rails.logger.info "There are: " + @comment_reviews.count.to_s + " records in comment_reviews"
    end
    def get_review
      @comment_review = CommentReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.fetch(:comment_review, {}).permit(:id,:comment_id,:review_text,:admin_id)
    end

   def log_action
    Rails.logger.info "in: #{params[:controller]} : #{params[:action]}" + (user_signed_in? ? " user: #{current_user.id.to_s}" : "")
    Rails.logger.info "params are: #{params.inspect}"
    Rails.logger.info "comment_id is: #{params[:comment_id]} "
  end

end
