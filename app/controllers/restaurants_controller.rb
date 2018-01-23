class RestaurantsController < ApplicationController
  before_action :new_restaurant, only: [:new, :create]
  before_action :load_restaurant, only: [:show, :edit, :update,  :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "New restaurant successfully added"
     redirect_to restaurant_path(@restaurant.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Restaurant successfully updated"
     redirect_to restaurant_path(@restaurant.id)
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    flash[:notice] = "Restaurant successfully deleted"
    redirect_to restaurants_path
  end

  private

  def new_restaurant
    @restaurant = Restaurant.new
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city, :price_range, :summary, :menu)
  end
end
