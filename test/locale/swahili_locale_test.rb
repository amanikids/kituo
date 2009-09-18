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

  def model_classes
    ActiveRecord::Base.send(:subclasses) - [Event, ActiveRecord::SessionStore::Session]
  end

  def accessible_attributes(klass)
    if klass.accessible_attributes
      klass.accessible_attributes
    else
      instance = klass.new
      instance.send(:remove_attributes_protected_from_mass_assignment, instance.attributes).keys
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

    should_eventually 'translate every model name' do
      assert_has_all_of model_classes.map { |klass| "activerecord.models.#{klass.name.underscore}" }, deep_keys(locale(:sw))
    end

    should_eventually 'translate every accessible attribute name' do
      assert_has_all_of model_classes.map { |klass| accessible_attributes(klass).map { |attribute| "activerecord.attributes.#{klass.name.underscore}.#{attribute}" } }.flatten, deep_keys(locale(:sw))
    end
  end
end
