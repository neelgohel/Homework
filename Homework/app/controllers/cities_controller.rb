class CitiesController < ApplicationController
  before_action :authenticate_admin!
  before_filter :load_city,except:[:index,:new,:create]
  layout 'admin'

  def load_city
    @city = City.find_by(id:params[:id])
  end

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.save
      redirect_to @city
    else
      render :new
    end
  end

  def show
    if @city.present?
      @cleaners_in_city = []
      @city.cleaners.each do |cleaner|
        @cleaners_in_city.push(cleaner)
      end
    else
      flash[:alert] = "Something Went Wrong"
      redirect_to cities_path
  end

  def edit
    if @city.nil?
      flash[:alert] = "Something Went Wrong"
      redirect_to cities_path
    end
  end

  def update
    if @city.update(city_params)
      redirect_to @city
    else
      render :edit
    end
  end

  def destroy
    @city.destroy
    redirect_to cities_path
  end

  private
  def city_params
    params.require(:city).permit(:city_name)
  end
end
