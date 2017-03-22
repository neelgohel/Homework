class AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    flash[:notice] = ""
    @customers = Customer.all
  end

  def show
    redirect_to admins_path
  end

end
