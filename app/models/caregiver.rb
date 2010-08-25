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

  before_validation :normalize_name
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_roles
    %w(
      social_worker
      social_work_coordinator
      development_officer
      database_administrator
    )
  end

  def friendly_name
    name.split(' ')[0]
  end

  def recommended_visits(options = {})
    all_visits = children.map { |child| RecommendedVisit.for(child) }.compact
    options.has_key?(:limit) ? all_visits.shuffle.take(options[:limit]) : all_visits
  end

  private

  def normalize_name
    self.name = name.to_s.squish.titlecase
  end
end
