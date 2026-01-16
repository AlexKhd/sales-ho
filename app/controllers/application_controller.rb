class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern, unless: -> { Rails.env.test? }

  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def set_locale
      I18n.locale = extract_locale_from_params || I18n.default_locale
    end

    def extract_locale_from_params
      params[:locale] if I18n.available_locales.map(&:to_s).include?(params[:locale])
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :nickname ])
      devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :nickname ])
    end
end
