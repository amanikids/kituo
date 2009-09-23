class Event < ActiveRecord::Base
  belongs_to :child

  # including id makes sure our blindingly-fast tests don't see weirdness due
  # to the second-only precision of updated_at
  default_scope :order => 'happened_on, updated_at, id'

  named_scope :happened_by, lambda { |date| { :conditions => ['happened_on <= ?', date] }}
  # it's important to keep the lambda, since the subclasses won't have loaded yet
  named_scope :location_changing, lambda { { :conditions => { :type => location_changing_event_names }}}

  validates_presence_of :happened_on
  validate :did_not_happen_in_the_future, :if => :happened_on
  after_update  :recalculate_child_state!, :if => :happened_on_changed?
  after_destroy :recalculate_child_state!

  def to_state
    raise("Must be implemented by subclasses (#{self.class})")
  end

  def self.location_changing_event_names
    %w(Arrival Dropout OffsiteBoarding Reunification Termination)
  end

  def self.location_changing_events
    location_changing_event_names.map(&:constantize)
  end

  def self.for_state(state)
    state_changing_events.detect {|x|
      x.new.to_state == state
    }
  end

  def self.state_changing_events
    [Arrival, OffsiteBoarding, Reunification, Dropout, Termination]
  end

  private

  def did_not_happen_in_the_future
    errors.add(:happened_on, :not_in_the_future) if happened_on.future?
  end

  def recalculate_child_state!
    child.recalculate_state!
  end
end
