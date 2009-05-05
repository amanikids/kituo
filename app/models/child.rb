class Child < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :arrivals
  accepts_nested_attributes_for :arrivals
  validates_presence_of :name
  validate :no_potential_duplicates_found, :unless => :ignore_potential_duplicates
  attr_accessor :ignore_potential_duplicates

  # FIXME oh no we di'int
  def potential_duplicates
    NameMatcher.new(Child.all.map(&:name)).match(self.name).map { |n| Child.find_all_by_name(n) }.flatten
  end
  memoize :potential_duplicates

  private

  def no_potential_duplicates_found
    errors.add_to_base('Potential duplicates found') if potential_duplicates(:reload).any?
  end
end
