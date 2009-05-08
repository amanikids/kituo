# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_with_current(name, options = {}, html_options = {})
    html_options.merge!(:class => 'current') if current_page?(options)
    link_to name, options, html_options
  end
end
