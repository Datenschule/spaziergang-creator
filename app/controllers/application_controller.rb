class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

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
end
