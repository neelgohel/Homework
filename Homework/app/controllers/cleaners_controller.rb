class CleanersController < ApplicationController
before_action :load_city,only:[:new,:create,:edit,:update]
layout 'admin'


  def load_city
      @city = City.all
  end

  def index
    @cleaners = Cleaner.all
  end

  def new
    @cities = []
    @cleaner = Cleaner.new
  end

  def create
    @city = City.all
    @cities = []
    @cleaner = Cleaner.new(cleaner_params)
      if @cleaner.save
        params[:city_ids].each do |id|
          CitiesCleaner.create(city_id:id,cleaner_id:@cleaner.id)
        end
        redirect_to @cleaner
      else
        render :new
      end
  end

  def edit
    @cleaner = Cleaner.find(params[:id])
    @cities = []
    @cleaner.cities.each {|city| @cities.push(city.id)}
  end

  def update
    @cleaner = Cleaner.find(params[:id])
    if @cleaner.update(cleaner_params)
      CitiesCleaner.where(cleaner_id:@cleaner.id).destroy_all
      params[:city_ids].each do |id|
        CitiesCleaner.create(city_id:id,cleaner_id:@cleaner.id)
      end
      redirect_to @cleaner
    else
      render :edit
    end
  end

  def show
    @cleaner = Cleaner.find(params[:id])
    @city_names = []
    @cleaner.cities.each{|city| @city_names.push(city.city_name) }
  end

  def destroy
    @cleaner = Cleaner.find(params[:id])
    @cleaner.destroy
    redirect_to cleaners_path
  end

  private
  def cleaner_params
    params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :email)
  end

end
