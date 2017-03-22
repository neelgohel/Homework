class CustomersController < ApplicationController
  before_action :authenticate_customer!

  layout 'customers'
  def index

    flash[:notice] = ""
    @bookings = current_customer.bookings
  end

  def show
    redirect_to customers_path
  end

end
