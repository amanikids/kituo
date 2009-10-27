# An event is recorded against a child for major things like a child arriving
# at amani, or moving back with their family. See subclasses for the different
# types of events.
class Event < ActiveRecord::Base
  belongs_to :child

  # including id makes sure our blindingly-fast tests don't see weirdness due
  # to the second-only precision of updated_at
  default_scope :order => 'happened_on, updated_at, id'

  named_scope :happened_by, lambda { |date| { :conditions => ['happened_on <= ?', date] }}
  # it's important to keep the lambda, since the subclasses won't have loaded yet
  named_scope :state_changing, lambda { { :conditions => { :type => state_changing_events.map(&:name) }}}

  validates_presence_of :happened_on
  validate :did_not_happen_in_the_future, :if => :happened_on
  after_save    :recalculate_child_state!, :if => :happened_on_changed?
  after_destroy :recalculate_child_state!

  def self.for_state(state)
    state_changing_events.detect {|x| x.to_state == state }
  end

  def self.state_changing_events
    [Arrival, OffsiteBoarding, Reunification, Dropout, Termination]
  end

  def self.all_states(options = {})
    states = state_changing_events.map(&:to_state)
    states.unshift('unknown') if options[:include_unknown]
    states
  end

  def to_state
    self.class.to_state
  end

  private

  def did_not_happen_in_the_future
    errors.add(:happened_on, :not_in_the_future) if happened_on.future?
  end

  def recalculate_child_state!
    child.recalculate_state!
  end
end
