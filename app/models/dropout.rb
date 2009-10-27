# The child ran away, we don't know where they are
class Dropout < Event
  def self.to_state
    'dropped_out'
  end
end
