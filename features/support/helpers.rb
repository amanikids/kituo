module Kituo
  module Cucumber
    module Helpers

      def parse_date(date)
        if date
          Date.parse(date) rescue Chronic.parse(date).to_date
        else
          Date.today
        end
      end

    end
  end
end

World(Kituo::Cucumber::Helpers)
