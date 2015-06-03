class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :set_i18n_locale_from_params

  rescue_from "ActiveRecord::RecordNotFound", with: :notify_excepton
  protected
    def notify_exception
      @exception = env['action_dispatch.exception']
      ExceptionNotifier.notify_admin(@exception).deliverer_now
    end

    def authorize

      if request.format != "MIME::html"
        # authenticate_or_request_with_http_basic do |username, password|
        #   user = User.find_by(name: username);
        #   if user && user.authenticate(password) ? true : false
        #     true
        #   else
        #     false
        #   end
        # end
      else
        unless User.is_first_user? or User.find_by(id: session[:user_id])
          redirect_to login_url, notice: "Please log in"          
        end
      end
    end 

    def set_i18n_locale_from_params
      if params[:locale] #if the locale is specified in the url
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation is not available"
          logger.error(flash.now[:notice])
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end
end