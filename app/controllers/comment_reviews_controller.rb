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

    respond_to do |format|
      if @comment_review.save!
        format.html {redirect_to comment_reviews_path(comment_id: @comment_review.comment_id), notice: "Comment Review was successfully saved"}
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
      @comment_reviews = CommentReview.where('comment_id = ?', params[:comment_id])
    end
    def get_review
      @comment_review = CommentReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.fetch(:comment_review, {}).permit(:id,:comment_id,:review_text,:admin_id)
    end

   def log_action
    Rails.logger.info "in: #{params[:controller]} : #{params[:action]}  for user: " + current_user.id.to_s
    Rails.logger.info "params are: #{params.inspect}"
  end

end
