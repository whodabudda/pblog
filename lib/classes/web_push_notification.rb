class WebPushNotification

  attr_accessor :subscription, :title, :article,:article_url,:action,:icon , :body
  def initialize(
    subscription:, 
	title:, 
	article: nil,
	article_url: "",
	body: "A message from Whodabudda",
	action: "",
	icon: "/assets/44px-Wiki_letter_w.png"
	)
    # recognized values for params
    # Required: subscription, title
    # Optional: article(CommentableContent object), action, icon
    # 
    	@subscription = subscription
	@title = title
	@article = article
	@article_url = article_url
	@action = action 
	@icon = icon
	@body = body
    set_defaults
  end

  def call
    pushHash = notification_message
    Rails.logger.info "WebPushNotification.call sending: #{pushHash}" 
    Webpush.payload_send pushHash
  end

  #
  #If the subscription was sent as a request from the browser, it will be stored with escape
  # characters to make it acceptable to http (i.e. a String).  If gotten directly from the database, it may already
  # be in JSON key/value format (i.e. a Hash).
  # Usually, the only need to use this conversion method is if the 'test notification' link is used
  # from the User Options form. 
  def prepare_subscription
      Rails.logger.info "webpush subscription before conversion?: #{subscription} : #{subscription.class}" 
      subh = ActiveSupport::JSON.decode(subscription)
      # 02/20/2020 This is a kludgie workaround to the situation where we have subscriptions strings 
      # that have somehow been JSON.parse multiple times.
      i = 0
      until subh.is_a? Hash or i == 3
        subh = ActiveSupport::JSON.decode(subh)
        i += 1
      end
      Rails.logger.info "webpush subh after decode?: #{subh} : #{subh.class} iterations #{i.to_s}" 
      subh = subh.deep_symbolize_keys
      @subscription = subh
      Rails.logger.info "webpush params subscription after conversion?: #{subscription} : #{subscription.class}" 
  end

private

#  def validate
#	 raise "missing_subscription_error" if !subscription
#	 raise :missing_title_error if !title 
#  end

  def set_defaults

    #if an article was passed in, set the action to launch the article
    #in a browser on click, set the body to the extract of the article
    #and set the title of the action to the title of the article
    if article 
	    @action = 'launch-action'
    	@body = article.extract 
    end

    if subscription.is_a? String   #if not yet converted to Hash
      prepare_subscription
    end
  end

  def build_message
     message = {
        title: title,
        body: body,
        icon: icon
     }
    if(article)
		add_to_message = {
          actions: [{
            action: @action,
            title: article.title,
            article_url: '/commentable_contents/show_by_id?id=' + article.id.to_s
          }]
		}

    Rails.logger.info "WebPushNotification.build_message message: #{message}" 
    Rails.logger.info "WebPushNotification.build_message add_to_message: #{add_to_message}" 
		message.merge!(add_to_message)
    end
  Rails.logger.info "WebPushNotification.build_message returning: #{message}" 
	message
  end

  def vapid
      rtn = {
        subject: "mailto:whodabudda@gmail.com",
        public_key: ENV['VAPID_PUBLIC'],
        private_key: ENV['VAPID_PRIVATE']
      }
  end
  def notification_message
      Rails.logger.info "notification_message endpoint?: #{subscription[:endpoint]}" 
      endpoint = subscription[:endpoint]
      p256dh = subscription[:keys][:p256dh]
      auth = subscription[:keys][:auth]
      { message: JSON.generate(build_message), endpoint: endpoint, p256dh: p256dh, auth: auth, api_key: "", vapid: vapid }
   end   
end

=begin
wp = WebPushNotification.new({
     subscription: {:endpoint=>
    "https://updates.push.services.mozilla.com/wpush/v2/gAAAAABdxtrFHNIFHYYEKSQdO0dG40SBLeT1CC3i7fRbkrBfoCkTHcX8zOm4_PS-nw3E8H59RtkCtM4atfMSuhExJvLhQX3bf-VCnC1J4qj7RWA-lwL3e3WYR0k8eiCwgs-huLyPHObHLuZY2i6cZvRKp0lIw30LSUCN3_U7L9WYvDK6-8BIuRo", :keys=> {:auth=>"h1tpvUgEphIj74uq21P5MQ", :p256dh=>"BJLW-XjQKONatSWmkZ0KIephuVYlvCvtLPapXH9hqk8WazIASnbPI0jpnqJZVZiPY-ZcKjXfTuw08PnX2dqccHQ"}},
 :title=>"How I won the War"}) 
=end