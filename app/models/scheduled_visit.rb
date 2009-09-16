class ScheduledVisit < ActiveRecord::Base
  belongs_to :child

  named_scope :before, lambda {|date| {
    :conditions => ['scheduled_for <= ?', date],
    :order      => 'scheduled_for ASC'
  }}
end
