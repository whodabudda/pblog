class UserMailer < ApplicationMailer
  default from: 'noreply@whodabudda.com'
 
  def new_comment
    @user = params[:user]
    mail(to: @user.email, subject: 'Your comment on Whodabudda')
  end
  def new_article
    @user = params[:user]
    @article = params[:article]
    #Carrierwave uploader has some odd structures where you can't just say 'filename'
    #but instead have to preface with the name of a nested structure, in this case 'file'
    @filename = @article.picture.file.filename
    attachments.inline[@filename] = File.read("#{@article.picture.file.file}")
    mail(to: @user.email, subject: 'A new Article on Whodabudda')
  end
  def comment_status_change
    @user = params[:user]
    @comment = params[:comment]
    mail(to: @user.email, subject: 'Your comment status has changed')
  end
  def new_comment_review
    @admin = params[:admin]
    @comment = params[:comment]
    @comment_review = params[:comment_review]
    mail(to: @admin.email, subject: 'Please Review new info from user')
  end
end