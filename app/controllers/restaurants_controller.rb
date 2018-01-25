class RestaurantsController < ApplicationController
  before_action :new_restaurant, only: [:new, :create]
  before_action :load_restaurant, only: [:show, :edit, :update,  :destroy]
  before_action :ensure_ownership, only: [:edit, :update]

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
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
    if @restaurant.update(restaurant_params)
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
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city, :price_range, :summary, :menu, :restaurant_id)
  end

  def ensure_ownership
    if session[:user_id] != @restaurant.user_id
      flash[:alert] = ["You don't own this restaurant!"]
      redirect_to root_path
    end
  end




end
