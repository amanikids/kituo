# The child arrived at Amani, and is now staying here
class Arrival < Event
  def self.to_state
    'on_site'
  end
end
