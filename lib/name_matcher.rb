# Used for searching for kids that sound like what you typed. This is necessary
# because of the wide variety of equivalent spellings in Swahili. As a downside
# we have to load all Child objects into memory in order to search. Does
# Not Scale but s'ok because it works for our expected dataset.
class NameMatcher
  SEARCH              = {:threshold => 0}
  DUPLICATE_DETECTION = {:threshold => 1}

  class Result < Struct.new(:search_string, :name)
    include Comparable

    def score
      score = 0

      words(name).each do |name_word|
        words(search_string).each do |search_word|
          if alpha_match?(name_word, search_word)
            score += 4
          elsif disregarding_trailng_vowels_match?(name_word, search_word)
            score += 3
          elsif full_soundex_match?(name_word, search_word)
            score += 2
          elsif partial_soundex_match?(name_word, search_word)
            score += 1
          end
        end
      end

      score
    end

    def <=>(other)
      other.score <=> self.score
    end

    private

    def words(string)
      string.downcase.split(/\s+/).map { |word| word.gsub(/[^a-z]/, '') }
    end

    def soundex_code(word)
      word.tr('r', 'l').soundex
    end

    def alpha_match?(a, b)
      a == b
    end

    def disregarding_trailng_vowels_match?(a, b)
      a.sub(/[aeiouy]+$/i, '') == b.sub(/[aeiouy]+$/, '')
    end

    def full_soundex_match?(a, b)
      soundex_code(a) == soundex_code(b)
    end

    def partial_soundex_match?(a, b)
      a = soundex_code(a).gsub(/0+$/, '')
      b = soundex_code(b).gsub(/0+$/, '')

      a.starts_with?(b) || b.starts_with?(a)
    end
  end

  def initialize(names)
    @names = names
  end

  def match(name, options = {})
    options[:mode] ||= SEARCH

    @names.map do |n|
      Result.new(name, n)
    end.reject do |r|
      r.score <= options[:mode][:threshold]
    end.sort.map { |r| r.name }
  end
end
