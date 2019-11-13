class UserOptionsController < ApplicationController
  before_action :set_user_option, only: [:show, :edit, :update, :destroy,:toggle_subscription]
  skip_before_action :authenticate_admin!
  before_action :show_params, only: [:send_push_notification]
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

  def send_push_notification
    Webpush.payload_send webpush_params
    respond_to do |format|
       format.js
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

    def webpush_params
      #subp = UserOption.find(1).subscription
      #Rails.logger.info "webpush_params subp: #{subp} : #{subp.class}"   
      subp = params[:subscription] 
      subp = ActiveSupport::JSON.decode(subp)
      subp = subp.deep_symbolize_keys
      Rails.logger.info "webpush_params as hash?: #{subp} : #{subp.class}" 
      #subp.keys.each do |key|
      #  subp[(key.to_sym rescue key) || key] = subp.delete(key)
      #end  
      #subp.to_h
      #JSON.parse(Base64.urlsafe_decode64(subp)).with_indifferent_access
      #message = CommentableContent.find(14).extract.to_s
      message = {
        title: "New Content at Whodabudda",
        body: CommentableContent.find(14).extract.to_s,
        icon: "/assets/44px-Wiki_letter_w.png",
        actions: [{
          action: 'launch-action',
          title: CommentableContent.find(14).title.to_s,
          article_url: '/commentable_contents/show_by_id?id=14'
        }]
      }
      vapid = {
        subject: "mailto:whodabudda@gmail.com",
        public_key: ENV['VAPID_PUBLIC_DEV'],
       private_key: ENV['VAPID_PRIVATE_DEV']
      }
      endpoint = subp[:endpoint]
      Rails.logger.info "webpush_params endpoint: #{endpoint}"   
      p256dh = subp[:keys][:p256dh]
      Rails.logger.info "webpush_params p256dh: #{p256dh}"   
      auth = subp[:keys][:auth]
      Rails.logger.info "webpush_params auth: #{auth}"  
      #icon = '/images/44px-Wiki_letter_w.png'
      { message: JSON.generate(message), endpoint: endpoint, p256dh: p256dh, auth: auth, api_key: "", vapid: vapid }
  #    api_key = enpoint =~ /\.google.com\// = ENV.fetch('GOOGLE_CLOUD_MESSAGE_API_KEY') || ""
  #    { message: message, endpoint: endpoint, p256dh: p256dh, auth: auth, api_key: api_key }
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
