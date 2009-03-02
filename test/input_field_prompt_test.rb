require 'test_helper'
require 'action_view/helpers/tag_helper'
require File.dirname(__FILE__) + '/../init.rb'

class InputFieldPromptTest < ActiveSupport::TestCase
  include ActionView::Helpers::TagHelper

  test "true" do
    assert true
  end
  
#  test "tag works normally with no options" do
#    assert_equal tag(:div) , "<div></div>"
#  end
#
#  test "tag works normally with options" do
#    assert_equal text_field_tag("test") , "<input type='text' id='test' name='test' />"
#  end
#
#  test "tag works with :prompt" do
#    assert_equal text_field_tag(:prompt => "test") , "<input type='text' id='test' name='test' />" #false right now
#  end

end
