# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_locale
  before_filter :store_location, :except => [ :new, :create, :edit, :update, :destroy ]

  helper :all
  prawnto :prawn => { :page_size => 'A4', :top_margin => 72 }
  protect_from_forgery

  # We may want to turn off footnotes in development mode from time to time to
  # see how the layout looks:
  # skip_after_filter Footnotes::Filter

  private

  def redirect_to(*args)
    return super if args.extract_options![:skip_contextual_magic]

    if location = session.delete(:location)
      super(location)
    else
      super
    end
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end

  def store_location
    session[:location] = request.path
  end
end
