class PublishArticleJob < ApplicationJob
  # queue_as :default

  def perform(article_id,publish_dttm)
  		article = CommentableContent.find(article_id)
  		if article.publish_dt == publish_dttm
  			notify_all_users(article)
  		end
  end
  def notify_all_users(article)
		User.joins(:user_options).where(user_options: {email:  true}).uniq.each do |user|
  			UserMailer.with(user: user,article: article).new_article.deliver_now	
  		end
		UserOption.where(notification:  true).each do |user_op|
			   messaging = WebPushNotification.new({
			    subscription: user_op.subscription,
        	    title: 'New Content at Whodabudda' ,
        	    article: article 
      			})
		    	messaging.call
  		end
  end
end
