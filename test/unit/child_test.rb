require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChildTest < ActiveSupport::TestCase
  should_have_many :events, :dependent => :destroy

  should_have_many :arrivals
  should_have_many :home_visits
  should_have_many :offsite_boardings
  should_have_many :reunifications
  should_have_many :dropouts
  should_have_many :terminations

  should_belong_to :social_worker

  should_have_attached_file :headshot

  should_validate_presence_of :name, :state
  should_allow_values_for :state, *Event.all_states(:include_unknown => true)
  should_not_allow_values_for :state, 'bogus'

  context '.create' do
    should 'set potential duplicate to false' do
      Child.make(:potential_duplicate => nil).potential_duplicate.should == false
    end

    should 'set potential duplicate to true if there is an existing child with the same name' do
      Child.make(:name => 'Juma Masawe')
      Child.make(:name => 'Juma Masawe').potential_duplicate.should == true
    end

    should 'set potential duplicate to true if there is an existing child with a similar name' do
      Child.make(:name => 'Juma Masawe')
      Child.make(:name => 'Jume Masawi').potential_duplicate.should == true
    end
  end

  context '.on_site' do
    should 'return children whose state is on_site' do
      expected = Child.make(:state => 'on_site')
      chaff    = Child.make(:state => 'boarding_offsite')

      Child.on_site.should == [expected]
    end
  end

  context '.recent' do
    should 'return recently added children' do
      expected = [
        Child.make(:created_at => 3.days.ago),
        Child.make(:created_at => 2.days.ago)
      ].reverse

      Child.recent.should == expected
    end
  end

  context '.search' do
    should 'return an empty list when given nil' do
      Child.search(nil).should == []
    end

    should 'only return one match per child' do
      name = 'Juma Masawe'
      expected = [
        Child.make(:name => name),
        Child.make(:name => name)
      ]
      Child.search(name).should == expected
    end
  end

  context '#next_states' do
    should 'include unknown when state is unknown' do
      Child.make(:state => 'unknown').next_states.should include('unknown')
    end

    should 'not include unknown when state is not unknown' do
      Child.make(:state => 'on_site').next_states.should_not include('unknown')
    end
  end

  should 'normalize name' do
    assert_equal "Emmanuel Lang'eda", Child.make(:name => "EMMANUEL lang'eda").name
  end

  context '#potential_duplicate_children' do
    should 'return other children with similar names' do
      child    = Child.make(:name => 'Juma Masawe')
      expected = Child.make(:name => 'Jume Masawi')
      chaff    = Child.make(:name => 'Rama Saidi')

      child.potential_duplicate_children.should == [expected]
    end
  end

  context "recalculating state after an event's date is updated" do
    should "calculate state from the last event that isn't a home visit" do
      chaff = Child.make(:state => 'terminated')
      child = Child.make(:state => 'unknown')

      child.reunifications.make(:happened_on => 4.days.ago)
      child.home_visits.make(:happened_on => 3.days.ago)
      child.arrivals.make(:happened_on => 2.days.ago)

      child.arrivals.last.update_attributes(:happened_on => 5.days.ago)
      child.reload.state.should == 'reunified'
      chaff.reload.state.should == 'terminated'
    end

    should 'give an unknown status when no events are present' do
      chaff = Child.make(:state => 'terminated')
      child = Child.make(:state => 'on_site')

      child.arrivals.destroy_all

      child.reload.state.should == 'unknown'
      chaff.reload.state.should == 'terminated'
    end
  end

  context '#length_of_stay' do
    setup { @child = Child.make }

    should 'be nil for a child with no Arrivals' do
      assert_nil @child.length_of_stay
    end

    context 'for a child who arrived 3 weeks ago' do
      setup do
        @child.arrivals.make(:happened_on => 3.weeks.ago)
      end

      should 'be number of days since Arrival' do
        assert_equal 21, @child.length_of_stay
      end

      context 'measuring from a different day' do
        should 'adjust the result' do
          assert_equal 14, @child.length_of_stay(1.week.ago)
        end

        should 'exclude newer events' do
          assert_nil @child.length_of_stay(4.weeks.ago)
        end
      end

      context 'and dropped out 2 weeks ago' do
        setup do
          @child.dropouts.make(:happened_on => 2.weeks.ago)
        end

        should 'be number of days from Arrival to Dropout' do
          assert_equal 7, @child.length_of_stay
        end
      end

      context 'and who, oops, also arrived 5 weeks ago (so that we make sure we honor ordering)' do
        setup do
          @child.arrivals.make(:happened_on => 5.weeks.ago)
        end

        should 'be number of days since Arrival' do
          assert_equal 35, @child.length_of_stay
        end
      end
    end
  end

  context '#on_site?' do
    should 'be true iff state is on_site' do
      child = Child.make(:state => 'unknown')
      child.on_site?.should == false
      child.state = 'on_site'
      child.on_site?.should == true
    end
  end

  context '#resolve_duplicate!' do
    context 'with no child' do
      setup do
        @child = Child.make
      end

      should 'update potential_duplicate flag to false' do
        @child.resolve_duplicate!(nil)
        @child.potential_duplicate.should == false
      end

      should 'not destroy the child' do
        @child.resolve_duplicate!(nil)

        lambda {
          @child.reload
        }.should_not raise_error(ActiveRecord::RecordNotFound)
      end

      should 'return the child' do
        @child.resolve_duplicate!(nil).should == @child
      end
    end

    context 'with a duplicate child' do
      should 'destroy the child' do
        child = Child.make
        duplicate = Child.make
        child.resolve_duplicate!(duplicate)
        lambda {
          child.reload
        }.should raise_error(ActiveRecord::RecordNotFound)
      end

      should 'return the duplicate' do
        child = Child.make
        duplicate = Child.make
        child.resolve_duplicate!(duplicate).should == duplicate
      end

      should 'repossess scheduled visits from the child to the duplicate' do
        child = Child.make
        duplicate = Child.make
        visit = child.scheduled_visits.make
        child.resolve_duplicate!(duplicate)

        duplicate.scheduled_visits.should include(visit)
      end

      should 'repossess events from the child to the duplicate' do
        child = Child.make
        duplicate = Child.make
        dropout = child.dropouts.make
        child.resolve_duplicate!(duplicate)

        duplicate.events.should include(dropout)
      end

      should "use the child's headshot if the duplicate doesn't have one" do
        child     = Child.make(:headshot => Rails.root.join('test', 'sample_headshot.jpg').open)
        duplicate = Child.make(:headshot => nil)
        child.resolve_duplicate!(duplicate)
        duplicate.reload.headshot.file?.should == true
      end

      should "not use the child's headshot if the duplicate already has one" do
        child     = Child.make(:headshot => Rails.root.join('test', 'sample_headshot.jpg').open)
        duplicate = Child.make(:headshot => Rails.root.join('test', 'sample_headshot_two.jpg').open)
        child.resolve_duplicate!(duplicate)
        duplicate.reload.headshot.original_filename.should == 'sample_headshot_two.jpg'
      end

      should "use the child's location if the duplicate doesn't have one" do
        child     = Child.make(:location => 'Moshi')
        duplicate = Child.make(:location => '')
        child.resolve_duplicate!(duplicate)
        duplicate.reload.location.should == 'Moshi'
      end

      should "not use the child's location if the duplicate already has one" do
        child     = Child.make(:location => 'Moshi')
        duplicate = Child.make(:location => 'Arusha')
        child.resolve_duplicate!(duplicate)
        duplicate.reload.location.should == 'Arusha'
      end

      should "use the child's social worker if the duplicate doesn't have one" do
        child     = Child.make(:social_worker => Caregiver.make)
        duplicate = Child.make(:social_worker => nil)
        child.resolve_duplicate!(duplicate)
        duplicate.reload.social_worker.should == child.social_worker
      end

      should "not use the child's social worker if the duplicate already has one" do
        child     = Child.make(:social_worker => Caregiver.make)
        duplicate = Child.make(:social_worker => Caregiver.make)
        child.resolve_duplicate!(duplicate)
        duplicate.reload.social_worker.should_not == child.social_worker
      end

      should 'recalculate state with the new events' do
        child     = Child.make
        duplicate = Child.make

        child.arrivals.make(:happened_on => 2.days.ago)
        duplicate.offsite_boardings.make(:happened_on => 3.days.ago)

        child.resolve_duplicate!(duplicate)
        duplicate.reload.state.should == 'on_site'
      end
    end
  end
end
