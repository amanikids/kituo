class Child < ActiveRecord::Base
  LOCATION_CHANGING_EVENTS = [Arrival, OffsiteBoarding, Reunification, Dropout, Termination]

  named_scope :by_name, :order => :name
  named_scope :location_as_of, lambda { |date|           { :conditions => ['events.id = (SELECT id FROM events WHERE child_id = children.id AND happened_on <= ? AND type in (?) ORDER BY happened_on DESC, created_at DESC LIMIT 1)', date, LOCATION_CHANGING_EVENTS.map(&:name)], :joins => :events }}
  named_scope :is,             lambda { |*event_classes| { :conditions => ['events.type IN (?)', event_classes.map(&:name)], :joins => :events }}
  named_scope :with,           lambda { |*event_classes| { :conditions => ['(SELECT COUNT(*) FROM events WHERE events.child_id = children.id AND events.type IN (?)) > 0', event_classes.map(&:name)] } }
  named_scope :without,        lambda { |*event_classes| { :conditions => ['(SELECT COUNT(*) FROM events WHERE events.child_id = children.id AND events.type IN (?)) = 0', event_classes.map(&:name)] } }

  def self.unrecorded_arrivals
    without(*LOCATION_CHANGING_EVENTS).scoped(:order => :created_at)
  end

  def self.upcoming_home_visits(date = Date.today)
    location_as_of(date).is(Arrival).without(HomeVisit).scoped(:include => :arrivals).sort_by { |child| child.arrivals.first.happened_on }
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

  has_many :events

  has_many :arrivals
  has_many :home_visits
  has_many :offsite_boardings
  has_many :reunifications
  has_many :dropouts
  has_many :terminations

  has_one :case_assignment
  has_one :social_worker, :through => :case_assignment

  has_attached_file :headshot,
    :url => '/system/:class/:attachment/:id/:style/:basename.:extension',
    :path => ':rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension',
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => '/images/headshot-:style.jpg'

  validates_presence_of :name
  validate_on_create :no_potential_duplicates_found, :unless => :ignore_potential_duplicates
  attr_accessor :ignore_potential_duplicates
  attr_accessible :name, :ignore_potential_duplicates, :headshot

  # FIXME oh no we di'int
  def self.search(name)
    NameMatcher.new(Child.all.map(&:name)).match(name).map { |n| Child.find_all_by_name(n) }.flatten
  end

  def potential_duplicates
    Child.search(name)
  end

  extend ActiveSupport::Memoizable
  memoize :potential_duplicates

  private

  def no_potential_duplicates_found
    errors.add_to_base('Potential duplicates found') if potential_duplicates(:reload).any?
  end
end
