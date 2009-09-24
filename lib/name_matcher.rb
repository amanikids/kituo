# Used for searching for kids that sound like what you typed. This is necessary
# because of the wide variety of equivalent spellings in Swahili. As a downside
# we have to load all Child objects into memory in order to search. Does
# Not Scale but s'ok because it works for our expected dataset.
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
