require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChildrenControllerTest < ActionController::TestCase
  context 'GET on_site.pdf' do
    setup do
      # Make sure we have some kids around to exercise the template:
      2.times { Child.make(:state => 'on_site') }
      get :on_site, :format => :pdf
    end

    should_respond_with :success
    should_respond_with_content_type :pdf
  end
end
