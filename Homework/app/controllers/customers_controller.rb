class CustomersController < ApplicationController
  before_action :authenticate_customer!

  layout 'customers'
  def index

    flash[:notice] = ""
    @bookings = current_customer.bookings
  end

end
