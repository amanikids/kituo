module Assertions
  def assert_contain_within_selector(selector, expected)
    selector = "css=#{selector}"
    wait_for do
      selenium.wait_for_element selector, :timeout_in_seconds => 5
      actual = selenium.get_text(selector)
      actual =~ /#{Regexp.escape(expected)}/
    end
  end

  def assert_not_contain_within_selector(selector, expected)
    selector = "css=#{selector}"
    wait_for do
      selenium.wait_for_element selector, :timeout_in_seconds => 5
      actual = selenium.get_text(selector)
      actual !~ /#{Regexp.escape(expected)}/
    end
  end
end

World(Assertions)
