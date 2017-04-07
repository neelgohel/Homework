class CustomersController < ApplicationController
  before_action :authenticate_customer!
  layout 'customers'

  def index
    @bookings = current_customer.bookings
  end

end
