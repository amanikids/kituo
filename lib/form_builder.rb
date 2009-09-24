class FormBuilder < ActionView::Helpers::FormBuilder
  # Pass the default label text through translations to get the correct
  # English or Swahili label
  def label(method, text = nil, options = {})
    super(method, text || @object.class.human_attribute_name(method.to_s), options)
  end

  # Provide an I18nized disable with label on submit buttons. This uses
  # prototype and interferes with jQuery hooks, so it will probably need
  # to be ditched.
  def submit(value = 'Save changes', options = {})
    super(value, options.merge(:disable_with => I18n.t('form.saving')))
  end
end
