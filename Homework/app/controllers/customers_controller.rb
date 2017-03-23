class CustomersController < ApplicationController
  before_action :authenticate_customer!

  layout 'customers'

  def index
    flash[:notice] = nil
    flash[:alert] = nil
    @bookings = current_customer.bookings
  end

  def show
    redirect_to customers_path
  end

  def new
    redirect_to customers_path
  end

  def edit
    redirect_to customers_path
  end

end
