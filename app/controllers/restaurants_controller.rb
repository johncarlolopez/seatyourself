class RestaurantsController < ApplicationController
  before_action :new_restaurant, only: [:new, :create]
  before_action :load_restaurant, only: [:show, :edit, :update,  :destroy]
  before_action :ensure_ownership, only: [:edit, :update]

  def index
    @restaurants = Restaurant.all
  end

  def show
    # ['Customer', 1], ['Restaurant Owner', 2]
    int_open_time = (@restaurant.opening_time.strftime("%H")).to_i
    int_close_time = (@restaurant.closing_time.strftime("%H")).to_i
    @restaurant_slots = []
    if int_close_time < int_open_time
      (24 - int_open_time).times {|t|
        @restaurant_slots << int_open_time + t
      }
      (0..int_close_time).each {|time|
        @restaurant_slots << time
      }
    else
      (int_open_time..int_close_time).each {|time|
        @restaurant_slots << time
      }
    end
    # puts "*************"
    # puts @restaurant_slots
    # puts "*************"

    # Remove timeslots that are already full
    # @restaurant.timeslots.each {|timeslot|
    #   ap timeslot
    # }
    @available_slots = []
    puts '*****************'
    ap @restaurant.timeslots
    @restaurant_slots.each {|slot|
      if slot.to_s.length == 1
        slot = "0" + slot.to_s
      else
        slot = slot.to_s
      end
      search = Time.now.utc.strftime("%d %b %Y")
      # ap search
      # search = "%" + search + " " + slot + "%"
      search = DateTime.parse(search + " " + slot + ":00:00").utc
      # ap search
      # puts "*********"
      # puts "Timeslots"
      # ap "class:#{@restaurant.timeslots.all.class}"
      # puts "*********"
      result = @restaurant.timeslots.all.where("timing = ? AND capacity <= 0", search)
      # result = @restaurant.timeslots.all.where(timing : search AND capacity <= 0)
      # ap "Result:"
      # ap result

      unless result.any?
        @available_slots << slot + ":00"
      else
        # puts "FULL for slot"
      end
    }

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
    params.require(:restaurant).permit(:name, :address, :city, :price_range, :summary, :menu, :restaurant_id, :opening_time, :closing_time, :capacity, :min_party, :max_party)
  end

  def ensure_ownership
    if session[:user_id] != @restaurant.user_id
      flash[:alert] = ["You don't own this restaurant!"]
      redirect_to root_path
    end
  end




end
