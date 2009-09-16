class Caregiver < ActiveRecord::Base
  named_scope :by_name, :order => :name

  has_many :children, :foreign_key => :social_worker_id

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
end
