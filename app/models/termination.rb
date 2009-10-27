# The child finished at Amani - likely they graduated, or we no longer need
# to support them
class Termination < Event
  def self.to_state
    'terminated'
  end
end
