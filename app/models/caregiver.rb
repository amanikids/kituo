class Caregiver < ActiveRecord::Base
  named_scope :by_name, :order => :name

  has_many :case_assignments, :foreign_key => :social_worker_id
  has_many :children, :through => :case_assignments

  has_attached_file :headshot,
    :url => '/system/:class/:attachment/:id/:style/:basename.:extension',
    :path => ':rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension',
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => "/images/headshot-:style.jpg"

  validates_presence_of :name
  attr_accessible :name, :headshot

  def tasks
    (unrecorded_arrivals + upcoming_home_visits).sort
  end

  private

  def unrecorded_arrivals
    children.unrecorded_arrivals.map { |child| Task.record_arrival(child) }
  end

  def upcoming_home_visits
    children.upcoming_home_visits.map { |child| Task.home_visit(child) }
  end
end
