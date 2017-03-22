class AdminsController < ApplicationController
  before_action :authenticate_not_customer
  before_action :authenticate_admin!

  def index

  end

  def authenticate_not_customer
    unless current_customer.nil?
      redirect_to customers_path
    end
  end
end
