module ActionView
  module Helpers

    module TranslationHelper
      def translate(key, options = {})
        options[:raise] = true
        I18n.translate(scope_keys_by_partial(key), options)
      end
      alias :t :translate
    end

  end
end
