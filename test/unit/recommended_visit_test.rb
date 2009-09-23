require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RecommendedVisitTest < ActiveSupport::TestCase
  context 'A recommended visit in general' do
    context '#completable?' do
      should 'be false' do
        RecommendedVisit.new(Child.make).completable?.should == false
      end
    end
  end

  # FIXME don't test RecommendedVisit through Caregiver
  context '#recommended_visits for children with no scheduled visits' do
    setup do
      @social_worker = Caregiver.make
      chaff = @social_worker.children.make(:state => :on_site)
      chaff.scheduled_visits.make
    end

    should 'include a child that has arrived and not had a visit' do
      not_arrived     = @social_worker.children.make
      arrived         = @social_worker.children.make(:state => :on_site)
      already_visited = @social_worker.children.make(:state => :on_site)
      already_visited.home_visits.make

      @social_worker.recommended_visits.map(&:child).should == [arrived]
    end

    should 'include a child that has arrived and has not had a visit in more than 1 month' do
      expected = @social_worker.children.make(:state => :on_site)
      expected.home_visits.make(:happened_on => (1.month + 1.day).ago)

      chaff = @social_worker.children.make(:state => :on_site)
      chaff.home_visits.make(:happened_on => 1.month.ago)

      @social_worker.recommended_visits.map(&:child).should == [expected]
    end

    should 'include a child that is offsite boarding and it is the start of the school term'

    should 'include a child that is reunified and has never been visited' do
      expected = @social_worker.children.make(:state => :reunified)

      chaff = @social_worker.children.make(:state => :reunified)
      chaff.home_visits.make(:happened_on => 3.months.ago)

      @social_worker.recommended_visits.map(&:child).should == [expected]
    end

    should 'include a child that is reunified and it is more than 3 months since their last visit' do
      expected = @social_worker.children.make(:state => :reunified)
      expected.home_visits.make(:happened_on => (3.months + 1.day).ago)

      chaff = @social_worker.children.make(:state => :reunified)
      chaff.home_visits.make(:happened_on => 3.months.ago)

      @social_worker.recommended_visits.map(&:child).should == [expected]
    end
  end
end
