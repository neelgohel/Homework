class AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    flash[:notice] = ""
  end
end
