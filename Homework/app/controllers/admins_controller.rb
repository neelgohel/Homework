class AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    flash[:notice] = ""
  end

  def show
    redirect_to admins_path
  end

end
