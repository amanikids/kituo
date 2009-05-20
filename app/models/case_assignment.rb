class CaseAssignment < ActiveRecord::Base
  belongs_to :child
  belongs_to :social_worker, :class_name => 'Caregiver'
  attr_accessible :child_id, :social_worker_id
end
