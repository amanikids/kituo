# The child has been reunified with their family. Amani is potentially still
# supporting the child via food and/or eductation aid.
class Reunification < Event
  def self.to_state
    'reunified'
  end
end
