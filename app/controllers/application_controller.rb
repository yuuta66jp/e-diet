class ApplicationController < ActionController::Base
  # devise_controllerの前に(before_action)作動
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # ログイン後のリダイレクト先を変更(マイページ)
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  # ログアウト後のリダイレクト先を変更(トップページ)
  def after_sign_out_path_for(resource)
    root_path
  end
  # sign_up時に許可するparameterの追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :gender, :birthday, :height, :goal_weight, :public_status])
    # nameをparameterとして使用可能とする
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

end
