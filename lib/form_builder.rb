class FormBuilder < ActionView::Helpers::FormBuilder
  # Localize the header_message, making allowance for the fact that Swahili
  # has different noun classes.
  def error_messages
    super(:header_message => @template.t(:header,
      :count => object.errors.count,
      :model => object.class.human_name,
      :scope => scope_for_noun(object, [:activerecord, :errors, :template])))
  end

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

  private

  def scope_for_noun(model, parent_scope)
    return parent_scope unless I18n.locale.to_sym == :sw

    noun_scope = {
      Caregiver => :mwa
    }.fetch(model.class)

    parent_scope + [noun_scope]
  end
end
