class CommentableContentsController < ApplicationController
  before_action :authenticate_admin!, except: [:show_by_id,:index,:show]
  skip_before_action :authenticate_user!
  before_action :set_commentable_content, only: [:show_by_id,:edit, :update, :destroy, :show]
  #before_action :log_action
  around_action :set_current_user_timezone , only: [:create,:update,:show_by_id]
  # GET /commentable_contents
  # GET /commentable_contents.json
  def index
    @commentable_contents = CommentableContent.all
  end

  # GET /commentable_contents/1
  # GET /commentable_contents/1.json
  def show_by_id
    @commentable_contents  = CommentableContent.find(params[:id])
    if params[:title].nil?
      @title = @commentable_contents.title
    else
      @title = params[:title]
    end
  end

  # GET /commentable_contents/new
  def new
    @commentable_content = CommentableContent.new
  end

  # GET /commentable_contents/1/edit
  def edit
  end

  def show
  end

  def create
    @commentable_content = CommentableContent.new(commentable_content_params)
    if params[:publish] == "1"
      @commentable_content.publish_dt = new DateTime.current
    end
    respond_to do |format|
      if @commentable_content.save
        cc = @commentable_content
        check_job(cc)
        @rtn_message = "Article was saved."
        format.html { redirect_to controller: "commentable_contents", title: cc.title, action: "show_by_id", id: cc.id , notice: @rtn_message }
        format.json { render :show, status: :created, location: @commentable_content }
      else
        format.html { render :new }
        format.json { render json: @commentable_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentable_contents/1
  # PATCH/PUT /commentable_contents/1.json
  def update
    Rails.logger.info "Params[publish_dt class is: #{params[:publish].class} #{params[:publish]}"
    Rails.logger.info " "
    Rails.logger.info "fetched params are: #{commentable_content_params}"
    respond_to do |format|
        if params[:publish][:publish] == "1"
          @commentable_content.publish_dt = DateTime.current
        end
      if @commentable_content.update(commentable_content_params)
        @rtn_message = "Article was saved."
        check_job(@commentable_content)
        if @commentable_content.publish_dt.nil?
          format.html { redirect_to edit_commentable_content_path, notice: @rtn_message }
        else
          format.html { redirect_to welcome_home_path , notice: @rtn_message }
        end
        format.json { render :show, status: :ok, location: @commentable_content }
      else
        format.html { render :edit }
        format.json { render json: @commentable_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentable_contents/1
  # DELETE /commentable_contents/1.json
  def destroy
    @commentable_content.destroy
    respond_to do |format|
      format.html { redirect_to commentable_contents_url, notice: 'Commentable content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_commentable_content
     @commentable_content = CommentableContent.find(params[:id])
  end

  def check_job(article)
    #
    # Don't allow notifications for publishing past 10 days from now.
    # Past that, the author will probably forget its in the queue.
    # Publish dates in the past will not have notifications sent,
    # although it may problematic to allow changes to content after publishing.
    # We mostly have to trust authors not to abuse this privilege.
    # If the publish_dt is in the past, it will not be allowed to be changed in the view.
    # In the job, if the passed in publish_dt no longer matches the database publish_dt,
    # no notifications will be sent. This protects against sending multiple notifications
    # when the published date is changed within its 10 day window.
    # If the date is beyone 10 days, no notifications will be sent unless it is edited and
    # the publish_dt set to be within 10 days.
    Rails.logger.info "CommentableContentsController-check_job publish_dt #{article.publish_dt}"
    if  article.publish_dt.nil?
        @rtn_message += "No publish date set. Regular users cannot view the article"
    else
        @rtn_message += "Article is now published and available to users for viewing. Notifictions will be sent."
        PublishArticleJob.set(wait_until: article.publish_dt).perform_later( article.id, article.publish_dt)
    end
  end

  def commentable_content_params
      params.fetch(:commentable_content, {}).permit(:picture,:title, :extract,:content,:created_by_id,:modified_by_id,:id,:publish_dt)
  end
  def log_action
    Rails.logger.info "in: #{params[:controller]} : #{params[:action]}  for user: " + (user_signed_in? ? current_user.id.to_s : "no user logged in")
    Rails.logger.info "params are: #{params.inspect}"
    Rails.logger.info "fetched params are: #{commentable_content_params}"
  end

end
