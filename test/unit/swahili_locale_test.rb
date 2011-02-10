require File.join(File.dirname(__FILE__), '..', 'test_helper')

class SwahiliLocaleTest < ActiveSupport::TestCase
  def locale(identifier)
    YAML.load_file(Rails.root.join('config', 'locales', "#{identifier}.yml")).fetch(identifier.to_s)
  end

  def deep_keys(obj, prefix=nil)
    case obj
    when Hash
      obj.map { |key, value| deep_keys(value, [prefix, key].compact.join('.')) }.flatten
    when NilClass, ''
      nil
    else
      prefix
    end
  end

  def assert_has_all_of(expected, actual)
    missing = expected - actual
    assert missing.empty?, "These keys are missing:\n#{missing.sort.to_yaml}"
  end

  context 'the Swahili locale' do
    setup do
      @swahili = locale(:sw)
    end

    should 'have every key from the English locale' do
      assert_has_all_of deep_keys(locale(:en)), deep_keys(locale(:sw))
    end

    should 'translate these attributes (the ones we think we use in forms)' do
      expected = %w(
        caregiver.name
        caregiver.role
        caregiver.headshot

        child.name
        child.location
        child.headshot
      ).map { |attribute|
        "activerecord.attributes.#{attribute}"
      }

      assert_has_all_of expected, deep_keys(locale(:sw))
    end
  end
end
