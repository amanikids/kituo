class Child < ActiveRecord::Base
  named_scope :by_name, :order => :name
  named_scope :on_site, :conditions => { :state => 'on_site' }
  named_scope :recent,  :order => 'created_at DESC'

  has_many :events, :dependent => :destroy
  has_many :arrivals
  has_many :home_visits
  has_many :offsite_boardings
  has_many :reunifications
  has_many :dropouts
  has_many :terminations

  has_many :scheduled_visits, :dependent => :destroy

  belongs_to :social_worker, :class_name => 'Caregiver'
  delegate :name, :to => :social_worker, :prefix => true, :allow_nil => true

  has_attached_file :headshot,
    :url => '/system/:class/:attachment/:id/:style/:basename.:extension',
    :path => ':rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension',
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => '/images/headshot-:style.jpg'

  before_validation :normalize_name
  validates_presence_of :name, :state
  validates_inclusion_of :state, :in => Event.all_states(:include_unknown => true)
  before_create :look_for_potential_duplicates
  after_save :create_events

  # FIXME search could use some refactoring attention
  def self.search(name)
    return [] if name.blank?
    matching_names = NameMatcher.new(Child.all.map(&:name)).match(name)
    Child.all.select { |child| matching_names.include?(child.name) }
  end

  Event.all_states(:include_unknown => true).each do |state|
    define_method(state + '?') do
      self.state == state
    end
  end

  def last_visited_on
    home_visits.last.try(:happened_on)
  end

  # Maybe this should use some sort of counter object? (YAGNI, until we need it more than once.)
  def length_of_stay(measured_on = Date.today)
    return nil if arrivals.happened_by(measured_on).empty?

    length_of_stay = 0
    current_stay_started_at = nil

    events.state_changing.happened_by(measured_on).each do |event|
      if current_stay_started_at
        length_of_stay += (event.happened_on - current_stay_started_at)
        current_stay_started_at = nil
      end

      if event.is_a?(Arrival)
        current_stay_started_at = event.happened_on
      end
    end

    if current_stay_started_at
      length_of_stay += (measured_on.to_date - current_stay_started_at)
    end

    length_of_stay
  end

  def next_states
    Event.all_states(:include_unknown => unknown?)
  end

  def potential_duplicate_children
    Child.search(self.name) - [self]
  end

  def recalculate_state!
    new_state = events.state_changing.last.try(:to_state) || 'unknown'
    Child.update_all(['state = ?', new_state], :id => id)
  end

  def resolve_duplicate!(duplicate)
    if duplicate
      destroy
      duplicate
    else
      update_attributes!(:potential_duplicate => false)
      self
    end
  end

  private

  def create_events
    if state_changed?
      Event.for_state(state).create!(
        :child       => self,
        :happened_on => Date.today
      )
    end
  end

  def look_for_potential_duplicates
    self.potential_duplicate = Child.search(self.name).any?
    true
  end

  def normalize_name
    self.name = self.name.to_s.squish.titlecase
  end
end
