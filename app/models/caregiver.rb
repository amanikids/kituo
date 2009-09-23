# This could be anyone who helps look after the kids, including the social
# workers, Japhary (manages social workers), and Joe (development officer).
# They may have different roles, for instance Joe doesn't make scheduled
# visits or directly look after kids.
class Caregiver < ActiveRecord::Base
  named_scope :by_name, :order => :name
  named_scope :social_workers, :conditions => { :role => 'social_worker' }

  has_many :children, :foreign_key => :social_worker_id
  has_many :scheduled_visits, :through => :children

  has_attached_file :headshot,
    :url => '/system/:class/:attachment/:id/:style/:basename.:extension',
    :path => ':rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension',
    :styles => { :default => '150x150#' },
    :default_style => :default,
    :default_url => "/images/headshot-:style.jpg"

  validates_presence_of :name
  attr_accessible :name, :headshot

  def tasks
    Task.for_caregiver(self)
  end

  def friendly_name
    name.split(' ')[0]
  end

  def recommended_visits(options = {})
    all_visits = children.map { |child| RecommendedVisit.for(child) }.compact
    options.has_key?(:limit) ? all_visits.shuffle.take(options[:limit]) : all_visits
  end
end
