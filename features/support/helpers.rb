module Kituo
  module Cucumber
    module Helpers

      def parse_date(date)
        case date
        when nil
          Date.today
        when /ago/
          Chronic.parse(date).to_date
        else
          Date.parse(date)
        end
      end

    end
  end
end

World(Kituo::Cucumber::Helpers)
