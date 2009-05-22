class FormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {})
    text = @object.class.human_attribute_name(method.to_s) if text.blank?
    super(method, text, options)
  end

  def submit(value = "Save changes", options = {})
    super(value, options.reverse_merge(:disable_with => I18n.t('form.saving')))
  end
end