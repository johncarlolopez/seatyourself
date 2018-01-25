class ReservationsController < ApplicationController

  before_action :new_reservation, only: [:new, :create, :confirmation]
  before_action :load_restaurant, only: [:show, :new, :create, :confirmation]
  before_action :ensure_login


  def show
  end

  def new
    # ['Customer', 1], ['Restaurant Owner', 2]
    puts "*****************"
    # puts "*****************"
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
    puts "*************"
    puts @restaurant_slots
    puts "*************"

    # Remove timeslots that are already full
    @restaurant.timeslots.each {|timeslot|
      ap timeslot
    }


  end

  def confirmation
    # render :confirmation
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.restaurant_id = params[:restaurant_id]
  end

  def create
    flash[:alert] = []
    @timeslot = Timeslot.new()
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.restaurant_id = params[:restaurant_id]

    # Split reservation time into two variables, one for day, one for hour
    # reservation_time = @reservation.time
    # reservation_day = @reservation
    # reservation_time = Time.parse(@reservation.time.strftime("%H") + ":00").utc
    # string_reservation_time = @reservation.time.strftime("%H") + ":00"
    # reservation_day = Date.parse(@reservation.time.strftime("%F")).utc
    # string_reservation_day = @reservation.time.strftime("%d %b %Y")
# ____
    # search if timeslot exists? Use Timeslot.find_by(timing, day, restaurant_id)
    # timeslot = Timeslot.find_by(timing: @reservation.time, restaurant_id: @restaurant.id)
    timeslot = Timeslot.where("timing = ? AND restaurant_id = ?", @reservation.time, @restaurant.id).first
    puts "**************"
      ap timeslot
    puts "**************"


    unless timeslot
      # if it doesnt exist create time slot - Timeslow.new using variables
      Timeslot.create(timing: @reservation.time, day: @reservation.time, capacity: @restaurant.capacity-@reservation.party_size, restaurant_id: @restaurant.id)
    else
      # Set reservation.timeslot_id to that timeslot.id
      @reservation.timeslot_id = timeslot.id
      new_capacity = timeslot.capacity - @reservation.party_size
      timeslot.update(capacity: new_capacity)
    end

    if @reservation.validates_reservation.any?
      @reservation.validates_reservation.each { |error|
        flash[:alert] << error
      }
      render :new
    elsif @reservation.save
     default_loyalty = 100
     flash[:alert] = []
     flash[:alert] << "Reservation successfully booked"
     @reservation.user.add_loyalty(default_loyalty)
     redirect_to restaurant_path(@restaurant.id)
    else
      render :new
    end
  end

  private

  def new_reservation
    @reservation = Reservation.new
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def reservation_params
    params.require(:reservation).permit(:time, :party_size)
  end

end
