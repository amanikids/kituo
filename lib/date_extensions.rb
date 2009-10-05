class Date
  # Amani's financial year starts on October 1st
  def at_beginning_of_financial_year
    (self + 3.months).beginning_of_year - 3.months
  end
end
