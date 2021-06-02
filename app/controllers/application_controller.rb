class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:top]
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        books_path
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    private

    def redirect_root
        redirect_to root_path unless user_signed_in?
    end
end
