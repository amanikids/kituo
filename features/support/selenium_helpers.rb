module SeleniumHelpers
  # Execute JavaScript in the context of your Selenium window
  def run_javascript(javascript)
    driver.get_eval <<-JS
      (function() {
        with(this) {
          #{javascript}
        }
      }).call(selenium.browserbot.getCurrentWindow());
    JS
  end

  private

  # If running in regular Selenium context, get_eval is defined on self.
  def driver
    respond_to?(:selenium) ? send(:selenium) : self
  end
end

World(SeleniumHelpers)
