# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_locale
  # filter_parameter_logging :password
  helper :all
  prawnto :prawn => { :page_size => 'A4', :top_margin => 72 }
  protect_from_forgery

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end
end
