# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]

  protected

  def reject_customer
    #入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      # 入力されたパスワードが正しいか確認
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false))
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_session_path
      end
    end
  end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

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
