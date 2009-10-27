# A transient migration class for when we added state to Child. Not required
# in to the future.
class StateMigrator
  def migrate!
    Child.find_each(&:recalculate_state!)
  end
end
