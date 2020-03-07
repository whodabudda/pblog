class AdminMailer < ApplicationMailer
  default from: 'noreply@whodabudda.com'

  def notify_all_admins(email_body, event)
    @admins = Admin.select(:email).distinct
    @admins.each do |admin| 
     mail(from: 'mailer@whodabudda.com',
     	 to: admin.email,
         body: email_body,
         content_type: "text/html",
         subject: event)
     end
  end
  def new_comment
    @admins = Admin.select(:email).distinct
    @user = params[:user]
    @comment = params[:comment]
    @admins.each do |admin| 
        mail(to: admin.email, subject: 'A new Comment on Whodabudda')
    end
  end
  def comment_reassigned
    @user = params[:user]
    @comment = params[:comment]
    @admin = params[:admin]
    #Rails.logger.info("comment_reassigned -- old admin: #{@comment.reviewed_by_was.to_s}")
    #@admin = Admin.find(@comment.reviewed_by_was)
    mail(to: @admin.email, subject: 'Admin Reassignment')
  end
  def new_comment_review
    @admin = params[:admin]
    @user = params[:user]
    @comment = params[:comment]
    @comment_review = params[:comment_review]
    mail(to: @admin.email, subject: 'Please Review new info from user')
  end
end