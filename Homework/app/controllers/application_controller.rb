class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    if params[:customer]
      customers_path
    else
      admins_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:alert] = ""
    flash[:notice] = ""
    new_customer_session_path
  end
end
