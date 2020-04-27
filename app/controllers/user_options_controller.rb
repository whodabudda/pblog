class UserOptionsController < ApplicationController
  before_action :authenticate_admin!,only: [:index]
  before_action :authenticate_user! , except: [:index]
  before_action :set_user_option, only: [:show, :edit, :update, :destroy,:toggle_subscription,:toggle_email,:send_test_push_notification]
  before_action :show_params, only: [:send_test_push_notification]
  before_action :set_delivery_method
  #
  #send_test_push_notification is an ajax call, however in the (hopefully rare) event that
  #Webpush returns an error, the edit view nees to be re-rendered entirely, in order to kick off
  #the javascript 'checkBrowserSupport' function, which then resets some classes on the user_options
  #form.  Thereby, it gets a little tricky, needing to return ajax when successful, but do
  #a full re-render of the view if it errors.  test_push_notification.js.erb does a page refresh to
  #accomplish this.
  #
  rescue_from  Webpush::ResponseError , with: :handle_webpush_error 
  # GET /user_options
  # GET /user_options.json
  def index
    @user_options = UserOption.all
  end

  # GET /user_options/1
  # GET /user_options/1.json
  def show
  end

  # GET /user_options/new
  def new
    @user_option = UserOption.new
  end

  # GET /user_options/1/edit
  def edit
    @user_option
  end
  def toggle_email
    if !(params.dig(:user_option,:email).nil?)
      @user_option.email = params.dig(:user_option,:email)
    else
      @user_option.email = false
    end      
    respond_to do |format|
     format.js { render 'toggle_email.js.erb', layout: false }
    end
  end

  def toggle_subscription
    @user_option
    #
    #A lot of s**t to go through just to get a true/false log value !!
    #
    Rails.logger.info "user_option.notification : " +  (!( params.dig(:user_option,:notification).nil?)).to_s  
    if !(params.dig(:user_option,:notification).nil?)
      @user_option.notification = params.dig(:user_option,:notification)
    else
      @user_option.notification = false
    end      
    respond_to do |format|
     format.js { render 'toggle_subscription.js.erb', layout: false }
     #format.js { render 'toggle_subscription.js.erb' }
     #format.js
    end
  end

  def send_test_email_notification
    @article = CommentableContent.last
    @user = User.find(params[:user_id])
  #  UserMailer.with(user: @user,article: @article).new_article(@delivery_method)
    UserMailer.with(user: @user,article: @article).new_article.deliver_now
    respond_to do |format|
       format.js
     end
  end
  def send_test_push_notification
    #required:  subscription, title, 
    #optional:  article(CommentableContent object)
    #          , action, icon
    @user_option
    @webpush_err = nil
    messaging = WebPushNotification.new({
     subscription: params[:subscription],
            title: 'New Content at Whodabudda' ,
            article: CommentableContent.last
      })
    messaging.call
#    rescue Webpush::ResponseError => e
#      Rails.logger.info e[:body][:code]

    respond_to do |format|
#       format.js { flash[:notice] =  "Notification was sent..." }
       format.js {}
     end

      #head :ok
  end


  # POST /user_options
  # POST /user_options.json
  def create
    @user_option = UserOption.new(user_option_params)

    respond_to do |format|
      if @user_option.save
        format.html { redirect_to :root, notice: 'User option was successfully created.' }
        format.json { render :show, status: :created, location: @user_option }
      else
        format.html { render :new }
        format.json { render json: @user_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_options/1
  # PATCH/PUT /user_options/1.json
  def update
    respond_to do |format|
      if @user_option.update(user_option_params)
        format.html { redirect_to :root, notice: 'User option was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_option }
      else
        format.html { render :edit }
        format.json { render json: @user_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_options/1
  # DELETE /user_options/1.json
  def destroy
    @user_option.destroy
    respond_to do |format|
      format.html { redirect_to user_options_url, notice: 'User option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    #deliver_now is good for development, where deliver_later might fail (see rails doc)
    #This creates some discomfort in that behaviour can be different between environments
    def set_delivery_method
        @delivery_method = (Rails.env == "production" ? 'deliver_later' : 'deliver_now')
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user_option
      @user_option = UserOption.find_by(user_id: current_user.id, browser: browser.name)
      if @user_option.nil?
        @user_option = UserOption.new(user_id: current_user.id , browser: browser.name)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_option_params
      params.require(:user_option).permit(:user_id, :email, :sms, :notification, :subscription,:browser)
    end
    def show_params
      Rails.logger.info "Displaying params: #{params} "

    end
    def handle_webpush_error(e)
      #regex to get all the characters between brackets {}.
      #Warning: This could be a problem if Zaru::Webpush ever changes the format of its error string.
      #Currently, the string error from Webpush has only one set of {}, whith the enclosed content
      #in a hash format.
      tmp = e.to_s[/{(.+)}/, 1] 
      #now parse into hash format, adding enclosing {} back in
      @webpush_err = JSON.parse("{#{tmp}}") 
      #
      #wipe out the subscription, since it failed.
      #TODO: check return codes; we probably only want to reset the subscription if it is actually 
      #expired.  If other errors, like too busy or content too long, subscription is actually ok 
      #and we need to take different action.
      #
      @user_option.subscription = ''
      @user_option.save

      Rails.logger.info "#{controller_name}:#{action_name} webpush code: #{@webpush_err["code"]} message: #{@webpush_err["message"]} "
     respond_to do |format|
      #format.js { redirect_to edit_user_option_path(@user_option), notice: @webpush_err["message"] }
       format.js { render 'send_test_push_notification.js.erb', layout: false }
     end

#      respond_to do |format| format.html { redirect_to edit_user_option_path, notice: "Unable to send notification #{e.message}" } end
    end

    def fetch_subscription
     # encoded_subscription = session.fetch(:subscription) do
     #   raise "Cannot create notification: no :subscription in params or session"
     # end
      #params.permit(:subscription)
      #encoded_subscription = params(:subscription)
      #JSON.parse(Base64.urlsafe_decode64(encoded_subscription)).with_indifferent_access
    end
end
