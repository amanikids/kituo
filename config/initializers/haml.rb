# Tell Haml to wrap html attributes with double instead of single quotes.
Haml::Template.options[:attr_wrapper] = '"'

# Have Sass generate easy-to-read css files.
Sass::Plugin.options[:style] = :expanded

# Require that Sass attributes be followed by either a colon or an equals sign.
Sass::Plugin.options[:attribute_syntax] = :alternate

# Tell Sass where our stylesheets are.
Sass::Plugin.options[:template_location] = Rails.root.join('app', 'stylesheets').to_s
Sass::Plugin.options[:css_location]      = Rails.root.join('tmp', 'stylesheets').to_s
