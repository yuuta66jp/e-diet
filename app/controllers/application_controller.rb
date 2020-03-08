class ApplicationController < ActionController::Base

  # ログイン済みユーザーにのみアクセスを許可する
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :birthday, :height, :goal_weight, :public_status])
  end

end
