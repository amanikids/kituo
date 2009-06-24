class Child < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  named_scope :by_name, :order => :name
  named_scope :location_as_of, lambda { |date|           { :conditions => ['events.id = (SELECT id FROM events WHERE child_id = children.id AND happened_on <= ? AND type in (?) ORDER BY happened_on DESC, created_at DESC LIMIT 1)', date, Event.location_changing_event_names], :joins => :events }}
  named_scope :is,             lambda { |*event_classes| { :conditions => ['events.type IN (?)', event_classes.map(&:name)], :joins => :events }}
  # TODO audit: do we ever say "with"?
  named_scope :with,           lambda { |*event_classes| { :conditions => ['(SELECT COUNT(*) FROM events WHERE events.child_id = children.id AND events.type IN (?)) > 0', event_classes.map(&:name)] } }
  named_scope :without,        lambda { |*event_classes| { :conditions => ['(SELECT COUNT(*) FROM events WHERE events.child_id = children.id AND events.type IN (?)) = 0', event_classes.map(&:name)] } }

  def self.unrecorded_arrivals
    without(*Event.location_changing_events)
  end

  def self.without_social_worker
    scoped(:conditions => '(SELECT COUNT(social_worker_id) FROM case_assignments WHERE case_assignments.child_id = children.id) = 0', :order => :created_at)
  end

  def self.upcoming_home_visits(date = Date.today)
    location_as_of(date).is(Arrival).without(HomeVisit).scoped(:include => :arrivals)
  end

  def self.onsite(date = Date.today)
    location_as_of(date).is(Arrival).by_name
  end

  def self.boarding_offsite(date = Date.today)
    location_as_of(date).is(OffsiteBoarding).by_name
  end

  def self.reunified(date = Date.today)
    location_as_of(date).is(Reunification).by_name
  end

  def self.dropped_out(date = Date.today)
    location_as_of(date).is(Dropout).by_name
  end

  def self.terminated(date = Date.today)
    location_as_of(date).is(Termination).by_name
  end

  has_many :events, :dependent => :destroy

  has_many :arrivals
  has_many :home_visits
  has_many :offsite_boardings
  has_many :reunifications
  has_many :dropouts
  has_many :terminations

  has_one :case_assignment, :dependent => :destroy
  has_one :social_worker, :through => :case_assignment

  has_attached_file :headshot,
    :url => '/system/:class/:attachment/:id/:style/:basename.:extension',
    :path => ':rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension',
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => '/images/headshot-:style.jpg'

  before_validation :normalize_name
  validates_presence_of :name
  validate_on_create :no_potential_duplicates_found, :unless => :ignore_potential_duplicates
  attr_accessor :ignore_potential_duplicates
  attr_accessible :name, :ignore_potential_duplicates, :headshot, :social_worker_id

  # FIXME oh no we di'int
  def self.search(name)
    NameMatcher.new(Child.all.map(&:name)).match(name).map { |n| Child.find_all_by_name(n) }.flatten
  end

  # Maybe this should use some sort of counter object? (YAGNI, until we need it more than once.)
  def length_of_stay(measured_on = Date.today)
    return nil if arrivals.happened_by(measured_on).empty?

    length_of_stay = 0
    current_stay_started_at = nil

    events.location_changing.happened_by(measured_on).each do |event|
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

  def potential_duplicates
    Child.search(name)
  end
  memoize :potential_duplicates

  delegate :id,   :to => :social_worker, :prefix => true, :allow_nil => true
  delegate :name, :to => :social_worker, :prefix => true, :allow_nil => true
  def social_worker_id=(social_worker_id)
    build_case_assignment(:social_worker_id => social_worker_id)
  end

  def tasks
    Task.for_child(self)
  end

  private

  def no_potential_duplicates_found
    errors.add_to_base('Potential duplicates found') if potential_duplicates(:reload).any?
  end

  def normalize_name
    self.name = self.name.to_s.squish.titlecase
  end
end
