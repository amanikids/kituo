module JavascriptHelper
  def add_javascript_requirement(*args)
    @required_javascripts ||= []
    args.each do |js|
      dependencies_for(js).each { |i| add_javascript_requirement(i) }
      @required_javascripts << js unless @required_javascripts.include?(js)
    end
  end
  alias_method :js, :add_javascript_requirement

  def dependencies_for(js)
    {
      :prototype => [],
      :effects => [:prototype],
      :dragdrop => [:prototype, :effects],
      :controls => [:prototype, :effects],
      :builder => [:prototype],
      :slider => [:prototype, :effects],
      :sound => [:prototype],
      :behaviour => [:prototype],
      :lowpro => [:prototype]
    }.merge(respond_to?(:js_dependencies) ? js_dependencies : {})[js.to_sym] || []
  end
  
  def javascript_tags
    (@required_javascripts || []).collect do |js|
      path = JavascriptHelperConfig.use_google_ajax_libs && google_ajax_libs_url(js) || "#{js}.js"
      javascript_include_tag(path)
    end.join("\n")
  end
  
  def google_ajax_libs_url(lib)
    if cfg = JavascriptHelperConfig.google_ajax_libs[lib.to_sym]
      url = cfg[:prefer_compressed] && cfg[:compressed_url] || cfg[:uncompressed_url]
      url.sub("{version}", cfg[:version])
    end
  end

  # used this class to name to avoid collisions since this is included in ApplicationHelper
  class JavascriptHelperConfig
    cattr_accessor :use_google_ajax_libs
    cattr_accessor :google_ajax_libs
    self.use_google_ajax_libs = false
    
    self.google_ajax_libs = {
      :jQuery => {
        :version => "1.2.6",
        :compressed_url => "http://ajax.googleapis.com/ajax/libs/jquery/{version}/jquery.min.js",
        :uncompressed_url => "http://ajax.googleapis.com/ajax/libs/jquery/{version}/jquery.js",
        :prefer_compressed => false
      },
      :prototype => {
        :version => "1.6.0.2",
        :uncompressed_url => "http://ajax.googleapis.com/ajax/libs/prototype/{version}/prototype.js"
      },
      :mootools => {
        :version => "1.11",
        :compressed_url => "http://ajax.googleapis.com/ajax/libs/mootools/{version}/mootools-yui-compressed.js",
        :uncompressed_url => "http://ajax.googleapis.com/ajax/libs/mootools/{version}/mootools.js",
        :prefer_compressed => false
      },
      :dojo => {
        :version => "1.1.1",
        :compressed_url => "http://ajax.googleapis.com/ajax/libs/dojo/{version}/dojo/dojo.xd.js",
        :uncompressed_url => "http://ajax.googleapis.com/ajax/libs/dojo/{version}/dojo/dojo.xd.js.uncompressed.js",
        :prefer_compressed => false
      }
    }
    
    # scriptaculous libraries
    %w{builder effects dragdrop controls slider sound}.each do |lib|
      self.google_ajax_libs[lib.to_sym] = {
        :version => "1.8.1",
        :uncompressed_url => "http://ajax.googleapis.com/ajax/libs/scriptaculous/{version}/#{lib}.js"
      }
    end
  end
end