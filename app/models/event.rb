class Event < ActiveRecord::Base
  attr_accessible :happened_on

  # including id makes sure our blindingly-fast tests don't see weirdness due
  # to the second-only precision of created_at
  default_scope :order => 'happened_on, created_at, id'
end
