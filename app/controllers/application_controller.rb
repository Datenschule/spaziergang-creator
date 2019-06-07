class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def render_403
    render file: Rails.root.join('public/403.html'), status: 403
  end

  def render_404
    render file: Rails.root.join('public/404.html'), status: 404
  end

  def bad_request
    render file: Rails.root.join('public/400.html'), status: 400
  end

  def is_user_blocked
    render_403 if current_user && current_user.blocked?
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
