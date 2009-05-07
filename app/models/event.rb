class Event < ActiveRecord::Base
  default_scope :order => 'happened_on, created_at'
end
