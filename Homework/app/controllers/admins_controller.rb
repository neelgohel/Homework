class AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    flash[:notice] = nil
    flash[:alert] = nil
    @customers = Customer.all
  end

  def show
    redirect_to admins_path
  end

  def edit
    redirect_to admins_path
  end

end
