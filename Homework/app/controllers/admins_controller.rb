class AdminsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @customers = Customer.all
  end
end
