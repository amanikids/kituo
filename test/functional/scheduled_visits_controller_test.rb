require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ScheduledVisitsControllerTest < ActionController::TestCase
  context 'with no current user' do
    context 'to create' do
      setup { xhr :post, :create }
      should_respond_with :forbidden
    end

    context 'to update' do
      setup { xhr :put, :create }
      should_respond_with :forbidden
    end
  end

  context 'with no child' do
    setup { session[:user_id] = Caregiver.make.id }

    context 'to create' do
      should 'be not found' do
        lambda {
          xhr :post, :create
        }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'a bad request' do
    setup do
      @child = Child.make(:social_worker => Caregiver.make)
      session[:user_id] = @child.social_worker_id
    end

    context 'to create' do
      setup { xhr :post, :create, :child_id => @child }
      should_respond_with :bad_request
    end

    context 'to update' do
      setup do
        visit = ScheduledVisit.make

        xhr :put, :update, :id => visit
      end

      should_respond_with :bad_request
    end
  end
end
