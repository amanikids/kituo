class Child < ActiveRecord::Base
  has_many :events

  has_many :arrivals
  accepts_nested_attributes_for :arrivals
  has_many :reunifications

  has_attached_file :headshot,
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => "/images/:attachment-:style.jpg"

  validates_presence_of :name
  validate_on_create :no_potential_duplicates_found, :unless => :ignore_potential_duplicates
  attr_accessor :ignore_potential_duplicates

  # FIXME oh no we di'int
  def potential_duplicates
    NameMatcher.new(Child.all.map(&:name)).match(self.name).map { |n| Child.find_all_by_name(n) }.flatten
  end

  extend ActiveSupport::Memoizable
  memoize :potential_duplicates

  private

  def no_potential_duplicates_found
    errors.add_to_base('Potential duplicates found') if potential_duplicates(:reload).any?
  end
end
