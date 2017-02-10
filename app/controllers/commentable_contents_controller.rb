class CommentableContentsController < ApplicationController
  before_action :set_commentable_content, only: [:show_by_id,:edit, :update, :destroy]
  before_action :get_commentable_type , :log_action

  # GET /commentable_contents
  # GET /commentable_contents.json
  def index
    @commentable_contents = @commentable_type.all
  end

  # GET /commentable_contents/1
  # GET /commentable_contents/1.json
  def show_by_id
    @type = params[:type]
    @title = params[:title]
    @commentable_contents  = @commentable_type.find(params[:id])
  end
  def show_by_type
    #@commentable_contents  = @commentable_type.all
    @type = params[:type]
    @title = params[:title]
    @commentable_contents = @commentable_type
  end

  # GET /commentable_contents/new
  def new
    @commentable_content = @commentable_type.new
  end

  # GET /commentable_contents/1/edit
  def edit
  end



#  def get_type
#    resource = request.path.split('/')[0]
#    @klass   = resource.singularize.capitalize.safe_constantize
#  end
  # POST /commentable_contents
  # POST /commentable_contents.json
  def create
    @commentable_content = CommentableContent.new(commentable_content_params)

    respond_to do |format|
      if @commentable_content.save
        format.html { redirect_to @commentable_content, notice: 'Commentable content was successfully created.' }
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
    respond_to do |format|
      if @commentable_content.update(commentable_content_params)
        format.html { redirect_to @commentable_content, notice: 'Commentable content was successfully updated.' }
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
      # blah blah
  def commentable_types
    ["Rogue", "CurrentEvent", "TruthInMedia"]
  end

  def get_commentable_type
    if params[:type].nil?
      @commentable_type = "CommentableContent".constantize
    elsif params[:type].in? commentable_types
      @commentable_type = params[:type].constantize if params[:type].in? commentable_types 
    else
      Rails.logger.info(params[:controller] + ":commentable_type  type is not in the list ".concat(params[:type].present?.to_s))
       format.html {render :nothing  }
     end
   end

    def get_type
       resource = request.path.split('/')[1]
       Rails.logger.info "CCC:get_type: " + request.path + " extracted to #{resource}"
        @klass   = resource.singularize.capitalize.camelize.constantize
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commentable_content_params
      params.fetch(@commentable_type.to_s.underscore.to_sym, {}).permit(:picture,:title, :extract,:content,:commentable_id,:created_by_id,:modified_by_id,:type,:id)
    end
   def log_action
    Rails.logger.info "in: #{params[:controller]} : #{params[:action]}  for user: " + (user_signed_in? ? current_user.id.to_s : "no user logged in")
    Rails.logger.info "params are: #{params.inspect}"
  end

end
