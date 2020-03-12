class ApplicationController < ActionController::Base

  # ログイン済みユーザーにのみアクセスを許可する(deviseのメッソド)
  #before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :gender, :birthday, :height, :goal_weight, :public_status])
    # nameをparameterとして使用可能とする
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

end
