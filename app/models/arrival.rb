class Arrival < ActiveRecord::Base
  default_scope :order => 'happened_on, created_at DESC'

  belongs_to :child
  accepts_nested_attributes_for :child
  delegate :name, :to => :child, :prefix => true
end
