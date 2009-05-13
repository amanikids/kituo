class Event < ActiveRecord::Base
  attr_accessible :happened_on
  default_scope :order => 'happened_on, created_at'
end
