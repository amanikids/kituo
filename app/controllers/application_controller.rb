# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  class BadRequest < RuntimeError; end;

  before_filter :redirect_to_next_locale
  before_filter :set_locale
  before_filter :store_location, :except => [ :new, :create, :edit, :update, :destroy ]

  helper :all
  prawnto :prawn => { :page_size => 'A4', :top_margin => 72 }
  protect_from_forgery

  rescue_from BadRequest do
    head(:bad_request)
  end

  # We may want to turn off footnotes in development mode from time to time to
  # see how the layout looks:
  # skip_after_filter Footnotes::Filter

  private

  def current_user
    @current_user ||= Caregiver.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def redirect_to_next_locale
    return unless params.has_key?(:next_locale)

    available     = I18n.available_locales
    current_index = available.index(params[:locale].to_sym)
    next_locale   = available[(current_index + 1) % available.size]

    redirect_to(url_for(:locale => next_locale))
  end

  def require_sign_in
    unless current_user
      if request.xhr?
        head(:forbidden)
      else
        redirect_to new_session_path
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale]
  end

  def store_location
    session[:location] = request.path
  end
end
