require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChildrenControllerTest < ActionController::TestCase
  context 'GET on_site.pdf' do
    setup do
      @expected_children = (1..2).map { Child.make(:state => 'on_site') }
      chaff = Child.make(:state => 'reunified')
      get :on_site, :format => :pdf
    end

    should_assign_to(:children) { @expected_children }
    should_respond_with :success
    should_respond_with_content_type :pdf
  end
end
