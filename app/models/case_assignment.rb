class CaseAssignment < ActiveRecord::Base
  belongs_to :child
  belongs_to :social_worker, :class_name => 'Caregiver'

  delegate :name, :headshot, :prefix => true, :to => :child
  delegate :name, :headshot, :prefix => true, :to => :social_worker

  validates_presence_of :social_worker_id
  attr_accessible :social_worker_id
end
