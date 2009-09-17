class Caregiver < ActiveRecord::Base
  named_scope :by_name, :order => :name

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

  class RecommendedVisit < Struct.new(:child)
    def self.for(child)
      return unless child.scheduled_visits.empty?

      if should_have_initial_home_visit?(child)
        new(child)
      elsif should_have_follow_up_home_visit?(child)
        new(child)
      elsif should_have_follow_up_home_visit_after_reunification?(child)
        new(child)
      end
    end

    def self.should_have_initial_home_visit?(child)
      child.on_site? && child.home_visits.empty?
    end

    def self.should_have_follow_up_home_visit?(child)
      child.on_site? && child.last_visited_on < 1.month.ago.to_date
    end

    def self.should_have_follow_up_home_visit_after_reunification?(child)
      child.reunified? && child.last_visited_on < 3.months.ago.to_date
    end
  end

  def recommended_visits
    children.map { |child| RecommendedVisit.for(child) }.compact
  end
end
