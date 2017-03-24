class Admins::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  before_action :check_customer
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

  def check_customer
    if customer_signed_in?
      redirect_to customers_path
    end
  end
end
