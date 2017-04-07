class CleanersController < ApplicationController
before_action :authenticate_admin!
before_action :load_city,only:[:new,:create,:edit,:update]
before_filter :load_cleaner,except:[:index,:new,:create]
layout 'admin'




  def index
    @cleaners = Cleaner.all
  end

  def new
    @cities = []
    @cleaner = Cleaner.new
  end

  def create
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
    if @cleaner.present?
      @cities = @cleaner.cities.pluck(:id)
    else
      flash[:alert] = "Something Went Wrong"
      redirect_to cleaners_path
    end
  end

  def update
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
    if @cleaner.present?
      @city_names = @cleaner.cities.pluck(:city_name)
    else
      flash[:alert] = "Something Went Wrong"
      redirect_to cleaners_path
    end
  end

  def destroy
    @cleaner.destroy
    redirect_to cleaners_path
  end

  private
  def cleaner_params
    params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :email)
  end

  def load_city
    @city = City.all
  end

  def load_cleaner
    @cleaner = Cleaner.find_by(id:params[:id])
  end

end
