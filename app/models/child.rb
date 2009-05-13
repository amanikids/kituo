class Child < ActiveRecord::Base
  default_scope :order => :name

  named_scope :pending, :joins => 'LEFT JOIN events on events.child_id = children.id', :conditions => 'events.id IS NULL'
  named_scope :is,    lambda { |event_class| { :joins => :events, :conditions => ['events.type = ?', event_class.name] }}
  named_scope :as_of, lambda { |date|        { :joins => :events, :conditions => ['events.id = (SELECT id FROM events WHERE child_id = children.id AND happened_on <= ? ORDER BY happened_on DESC, created_at DESC LIMIT 1)', date] }}

  def self.onsite(date = Date.today)
    is(Arrival).as_of(date)
  end

  def self.boarding_offsite(date = Date.today)
    is(OffsiteBoarding).as_of(date)
  end

  def self.reunified(date = Date.today)
    is(Reunification).as_of(date)
  end

  def self.dropped_out(date = Date.today)
    is(Dropout).as_of(date)
  end

  def self.terminated(date = Date.today)
    is(Termination).as_of(date)
  end

  has_many :events

  has_many :arrivals
  has_many :home_visits
  has_many :offsite_boardings
  has_many :reunifications
  has_many :dropouts
  has_many :terminations

  has_attached_file :headshot,
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => "/images/headshot-:style.jpg"

  validates_presence_of :name
  validate_on_create :no_potential_duplicates_found, :unless => :ignore_potential_duplicates
  attr_accessor :ignore_potential_duplicates
  attr_accessible :name, :headshot, :ignore_potential_duplicates

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
