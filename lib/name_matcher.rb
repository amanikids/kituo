# Used for searching for kids that sound like what you typed. This is necessary
# because of the wide variety of equivalent spellings in Swahili. As a downside
# we have to load all Child objects into memory in order to search. Does
# Not Scale but s'ok because it works for our expected dataset.
class NameMatcher
  SEARCH              = {:threshold => 0}
  DUPLICATE_DETECTION = {:threshold => 1}

  def initialize(names)
    @names = names
  end

  def match(search_string, options = {})
    options[:mode] ||= SEARCH

    results         = lambda {|name|   Result.new(search_string, name) }
    below_threshold = lambda {|result| result.score <= options[:mode][:threshold] }

    @names.collect(&results).reject(&below_threshold).sort.map(&:name)
  end

  private

  class Result < Struct.new(:search_string, :name)
    include Comparable

    SCORES = [
      [:alpha_match?,                       4],
      [:disregarding_trailng_vowels_match?, 3],
      [:full_soundex_match?,                2],
      [:partial_soundex_match?,             1]
    ]

    def score
      words(name).sum do |name_word|
        words(search_string).sum do |search_word|
          SCORES.detect {|condition, _|
            send(condition, name_word, search_word)
          }.try(:last).to_i
        end
      end
    end

    def <=>(other)
      other.score <=> self.score
    end

    private

    # Conditions
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

    # Conditions helpers
    def words(string)
      string.downcase.split(/\s+/).map { |word| word.gsub(/[^a-z]/, '') }
    end

    def soundex_code(word)
      word.tr('r', 'l').soundex
    end
  end
end
