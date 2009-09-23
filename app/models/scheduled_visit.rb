class ScheduledVisit < ActiveRecord::Base
  belongs_to :child

  named_scope :before, lambda {|date| {
    :conditions => ['scheduled_for <= ?', date],
    :order      => 'scheduled_for ASC'
  }}

  def complete!
    return unless completable?

    transaction do
      child.home_visits.create!(:happened_on => scheduled_for)
      destroy
    end
  end

  def completable?
    !scheduled_for.future?
  end
end
