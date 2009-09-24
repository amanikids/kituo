class FormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {})
    super(method, text || @object.class.human_attribute_name(method.to_s), options)
  end

  def submit(value = 'Save changes', options = {})
    super(value, options.merge(:disable_with => I18n.t('form.saving')))
  end
end
