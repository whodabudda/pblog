class WelcomeController < ApplicationController
  def home
  	@commentable_contents = CommentableContent.all
  end

  def about
  end

  def doc
  end

end
