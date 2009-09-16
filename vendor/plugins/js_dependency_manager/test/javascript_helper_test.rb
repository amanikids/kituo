require 'test/unit'
require 'rubygems'
require 'activesupport'
require 'javascript_helper.rb'


class JavascriptHelperTest < Test::Unit::TestCase
  include JavascriptHelper
  
  def test_add_javascript_requirement
    add_javascript_requirement(:foobar)
    assert @required_javascripts.include?(:foobar)
  end
  
  def test_user_specified_dependencies
    js(:needsmorefoobar)
    assert @required_javascripts.include?(:morefoobar)
  end
  
  def test_javascript_tags
    js(:taggies)
    assert (javascript_tags =~ /taggies\.js/)
  end
  
  def test_google_libs_when_true
    JavascriptHelper::JavascriptHelperConfig.use_google_ajax_libs = true
    js(:prototype)
    assert (javascript_tags =~ /googleapis/)
  end
  
  def test_no_google_libs_when_false
    JavascriptHelper::JavascriptHelperConfig.use_google_ajax_libs = false
    js(:prototype)
    assert (javascript_tags !~ /googleapis/)
  end
  
  def js_dependencies
    {
      :needsmorefoobar => [:morefoobar]
    }
  end
  
  private
  # Because this is a Rails Helper that we don't have here
  def javascript_include_tag(js_file)
    %Q{<script src="#{js_file}.js"></script>}
  end
end
