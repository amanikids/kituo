# The child is away at boarding school, but Amani is still supporting them
# by paying their school fees
class OffsiteBoarding < Event
  def self.to_state
    'boarding_offsite'
  end
end
