class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def after_sign_in_path_for(*)
    # home_url
    if current_user.admin?
      admin_path
    elsif current_user.user?
      root_url
    end
  end

  def edit
  end

  def update
  end

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "Record not found." }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :phone, :card, { roles: [] },
                         :email, :password, :password_confirmation)
    end
  end
end
