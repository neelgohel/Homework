class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    params[:customer] ? customers_path : admins_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_customer_session_path
  end
end
