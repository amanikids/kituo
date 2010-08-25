require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChildrenControllerTest < ActionController::TestCase
  context 'GET on_site.pdf' do
    setup do
      @expected_children = (1..2).map { Child.make(:state => 'on_site') }
      chaff = Child.make(:state => 'reunified')
      # prawnto doesn't take into account that this setting might be nil, so we
      # have to set it in the test.
      @request.env['SERVER_PROTOCOL'] = 'http'
      get :on_site, :format => :pdf
    end

    should_assign_to(:children) { @expected_children }
    should_respond_with :success
    should_respond_with_content_type :pdf
  end
end
