class Event < ActiveRecord::Base
  belongs_to :child

  # including id makes sure our blindingly-fast tests don't see weirdness due
  # to the second-only precision of created_at
  default_scope :order => 'happened_on, created_at, id'

  named_scope :happened_by, lambda { |date| { :conditions => ['happened_on <= ?', date] }}
  # it's important to keep the lambda, since the subclasses won't have loaded yet
  named_scope :location_changing, lambda { { :conditions => { :type => location_changing_event_names }}}

  attr_accessible :happened_on

  def to_state
    raise("Must be implemented by subclasses (#{self.class})")
  end

  def self.location_changing_event_names
    %w(Arrival Dropout OffsiteBoarding Reunification Termination)
  end

  def self.location_changing_events
    location_changing_event_names.map(&:constantize)
  end
end
