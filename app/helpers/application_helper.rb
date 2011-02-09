# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include JavascriptHelper

  def js_dependencies
    {
      :inline_edit   => %w(jquery-1.3.2),
      :change_locale => %w(jquery-1.3.2),
      :child_tasks   => %w(jquery-1.3.2),
      :child_scheduled_visits => %w(
        jquery-1.3.2
        jquery-ui-1.7.2.everything.min
      ),
      :scheduled_visits => %w(
        jquery-1.3.2
        jquery-ui-1.7.2.everything.min)
    }
  end

  def badged(text, count)
    if count.zero?
      text
    else
      text + ' ' + content_tag(:span, count, :class => 'badge')
    end
  end

  def link_to_with_current(name, current, options = {}, html_options = {})
    html_options.merge!(:class => 'current') if current
    link_to name, options, html_options
  end

  def link_to_with_current_full_path(name, options = {}, html_options = {})
    link_to_with_current(name, current_page?(options), options, html_options)
  end

  def link_to_with_current_partial_path(name, segment, options = {}, html_options = {})
    link_to_with_current name, request.path.include?("/#{segment}"), options, html_options
  end

  def other_locales
    other_locales = {}.with_indifferent_access
    I18n.available_locales.each { |locale| other_locales[locale] = t(:locale_name, :locale => locale) }
    other_locales.except(I18n.locale)
  end
end
