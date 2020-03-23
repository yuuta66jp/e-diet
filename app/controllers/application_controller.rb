class ApplicationController < ActionController::Base
  # devise_controllerの前に(before_action)作動
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ログイン後のリダイレクト先を変更
  def after_sign_in_path_for(resource)
    time0 = Time.current.midnight.advance(hours: -9)
    time1 = Time.current.end_of_day.advance(hours: -9)
    case resource
      when User
        # ログインポイント付与のメッセージ表示(1日1回)
        unless current_user.rewards.where(issue_reason: 1, created_at: time0..time1).exists?
          flash[:notice] = 'ログインポイント(5point)取得しました！'
        end
        user_path(current_user)
      when Admin
        admins_users_path
    end
  end
  # ログアウト後のリダイレクト先を変更(トップページ)
  def after_sign_out_path_for(resource)
    diaries_path
  end
  # sign_up時に許可するparameterの追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :gender, :birthday, :height, :goal_weight, :public_status])
    # nameをparameterとして使用可能とする
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

end
