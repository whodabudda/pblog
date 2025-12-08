require 'test_helper'

class CommentableContentTest < ActiveSupport::TestCase
   test "fixture has one article" do
     assert_equal 2, commentable_contents.length
   end
end
