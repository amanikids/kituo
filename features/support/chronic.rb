require 'chronic'
require 'chronic_extensions'

module ChronicHelpers
  def human_date(day)
    I18n.localize(
      Chronic.parse(day).to_date,
      :format => :human,
      :locale => 'en').strip
  end
end

World(ChronicHelpers)
