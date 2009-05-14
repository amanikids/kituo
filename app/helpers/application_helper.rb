# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def due_date_td(due_date)
    distance_in_weeks = (due_date.to_time - Date.today.to_time).to_i / 1.week
    due_in_the = %w(present future past)[distance_in_weeks <=> 0]
    content_tag(:td, t("due.#{due_in_the}", :phrase => t('datetime.distance_in_weeks', :count => distance_in_weeks.abs)), :class => "due #{due_in_the}")
  end

  def link_to_with_current(name, options = {}, html_options = {})
    html_options.merge!(:class => 'current') if current_page?(options)
    link_to name, options, html_options
  end

  def other_locales
    other_locales = {}.with_indifferent_access
    I18n.available_locales.each { |locale| other_locales[locale] = t(:locale_name, :locale => locale) }
    other_locales.except(I18n.locale)
  end

  def subnavigation
    try_render(@controller.class.subnavigation_template || 'subnavigation')
  end

  def try_render(*args)
    render *args
  rescue ActionView::MissingTemplate
    nil
  end
end

module ActionView
  module Helpers
    class InstanceTag
      def to_label_tag(text = nil, options = {})
        options = options.stringify_keys
        name_and_id = options.dup
        add_default_name_and_id(name_and_id)
        options.delete("index")
        options["for"] ||= name_and_id["id"]
        content = (text.blank? ? nil : text.to_s) || object.class.human_attribute_name(method_name)
        label_tag(name_and_id["id"], content, options)
      end
    end
  end
end