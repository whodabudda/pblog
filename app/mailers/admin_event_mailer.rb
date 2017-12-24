class AdminEventMailer < ApplicationMailer
  def notify_all_admins(email_body, event)
    @admins = Admin.select(:email).distinct
    @admins.each do |admin| 
     mail(to: admin.email,
         body: email_body,
         content_type: "text/html",
         subject: event)
     end
  end
end