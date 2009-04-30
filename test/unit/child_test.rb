require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChildTest < ActiveSupport::TestCase
  should_have_many :arrivals
  # TODO: reconsider if we really want to be so open with our arrivals
  should_accept_nested_attributes_for :arrivals

  should_validate_presence_of :name

  context 'given an existing Child' do
    setup do
      @existing_child = Child.make
    end

    should 'have no potential duplicate children' do
      assert_equal [], @existing_child.potential_duplicates
    end

    context 'a second child with the same name' do
      setup do
        @child = Child.make_unsaved(:name => @existing_child.name)
      end

      should 'not be valid' do
        assert !@child.valid?
      end

      should 'have potential duplicate children' do
        assert_equal [@existing_child], @child.potential_duplicates
      end

      should 'have :potential_duplicates_found error on base' do
        @child.valid?
        assert @child.errors.on(:base).include?('Potential duplicates found')
      end

      context 'overriding duplicate check' do
        setup do
          @child.ignore_potential_duplicates = 'Some string from the button name'
        end

        should 'be valid' do
          assert @child.valid?
        end
      end
    end
  end
end
