module DateHelper
  # For example, 10 Feb 2011.
  def human_date(string)
    I18n.localize(
      parse_date(string),
      :format => :human,
      :locale => 'en').strip
  end

  def parse_date(string)
    case string
    when 'today'
      Date.today
    when /^the (\d+)(?:st|nd|rd|th) day of this month$/i
      Date.today.beginning_of_month + $1.to_i.day - 1.day
    when 'Wednesday last week'
      Date.today.beginning_of_week - 5.days
    else
      raise "Don't know how to parse '#{string}'"
    end
  end
end

World(DateHelper)
