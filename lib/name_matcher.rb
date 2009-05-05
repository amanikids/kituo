class NameMatcher
  def initialize(names)
    @names = names
  end

  def match(name)
    @names.select { |n| (soundex_codes(name) & soundex_codes(n)).any? }
  end

  private

  def soundex_codes(string)
    string.split(/\s+/).map { |word| word.gsub(/[^A-Za-z]/, '').tr('Rr', 'Ll').soundex[0..1] }
  end
end
