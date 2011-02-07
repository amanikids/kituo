# This seems to be necessary until the next cucumber-rails update.
class Capybara::Driver::Node
  def node
    native
  end
end
