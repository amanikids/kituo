# Adds the following to Chronic, where X is first|second|third:
#   the X day the month
#   X day this month
#
# These are used in our selenium tests. There is an issue on github to support
# these dates: http://LINK
module Chronic
  class << self
    def parse_with_month_support(input, options = {})
      if input =~ /^(?:the )?(\w+) day (?:of )?this month$/i
        ordinals = %w(first second third)
        Chronic.parse("today", options).beginning_of_month + ordinals.index($1.downcase).day
      else
        parse_without_month_support(input, options)
      end
    end

    alias_method_chain :parse, :month_support
  end
end
