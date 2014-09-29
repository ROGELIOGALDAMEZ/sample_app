require 'test_helper'

describe PagesController do
  render_views
end

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end
  
  test "should have the right title" do
    get :home
    response.should have_selector("Title", :content => "Ruby on Rails Tut Sample App | Home")
  end
  
  test "should have a non-blank body" do
    get :home
    response.body.should_not =~ /<body>\s*<\/body>/
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end
  
   test "should have the right title" do
    get :contact
    response.should have_selector("Title", :content => "Ruby on Rails Tut Sample App | Contact")
  
  test "should get contact" do
    get :about
    assert_response :success
    
     test "should have the right title" do
    get :about
    response.should have_selector("Title", :content => "Ruby on Rails Tut Sample App | About")
  end


end
