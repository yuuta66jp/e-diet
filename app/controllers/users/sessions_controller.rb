# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     super
     # sign_in時のポイント機能(１日1回付与)(UTC時刻を基準にしているため時差分-9時間調整)
     time0 = Time.current.midnight.advance(hours: -9)
     time1 = Time.current.end_of_day.advance(hours: -9)
     # 同じハッシュ内に複数並べ条件を追加
     unless current_user.rewards.where(issue_reason: 1, created_at: time0..time1).exists?

       @point = current_user.rewards.build(
         user_id:      current_user.id,
         point:        20,
         issue_reason: 1
         )
       @point.save

     end
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
