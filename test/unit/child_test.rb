require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChildTest < ActiveSupport::TestCase
  should_have_many :events

  should_have_many :arrivals
  should_have_many :home_visits
  should_have_many :offsite_boardings
  should_have_many :reunifications
  should_have_many :dropouts
  should_have_many :terminations

  should_have_one :case_assignment
  should_have_one :social_worker

  should_have_attached_file :headshot

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
