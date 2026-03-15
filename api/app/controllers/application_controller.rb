class ApplicationController < ActionController::Base
  inertia_share current_user: -> { current_user&.slice(:id, :first_name, :last_name, :email, :profile_picture) }

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login!
    redirect_to root_path unless current_user
  end
end
