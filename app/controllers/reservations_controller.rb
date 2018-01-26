class ReservationsController < ApplicationController

  before_action :new_reservation, only: [:new, :create, :confirmation]
  before_action :load_restaurant, only: [:show, :new, :create, :confirmation]
  before_action :ensure_login


  def show
  end

  def new
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

    timeslot = Timeslot.where("timing = ? AND restaurant_id = ?", @reservation.time, @restaurant.id).first
    if @reservation.party_size > @restaurant.capacity
      flash[:alert] = []
      flash[:alert] << "Sorry we do not have enough space to accomodate your party size"
      redirect_to new_restaurant_reservation_path(@restaurant.id) and return
    end

    unless timeslot
      # if it doesnt exist create time slot - Timeslow.new using variables
      timeslot = Timeslot.create(timing: @reservation.time, day: @reservation.time, capacity: @restaurant.capacity-@reservation.party_size, restaurant_id: @restaurant.id)
    else
      # Set reservation.timeslot_id to that timeslot.id
      if @reservation.party_size > timeslot.capacity
        flash[:alert] = []
        flash[:alert] << "Sorry we do not have enough remaining space to accomodate your party size"
        redirect_to new_restaurant_reservation_path(@restaurant.id) and return
      end
      @reservation.timeslot_id = timeslot.id
      new_capacity = timeslot.capacity - @reservation.party_size
      timeslot.update(capacity: new_capacity)
    end
    @reservation.timeslot_id = timeslot.id
    if @reservation.validates_reservation.any?
      @reservation.validates_reservation.each { |error|
        flash[:alert] << error
      }
      redirect_to new_restaurant_reservation_path(@restaurant.id) and return
    elsif @reservation.save
     default_loyalty = 100
     flash[:alert] = []
     flash[:alert] << "Reservation successfully booked"
     @reservation.user.add_loyalty(default_loyalty)
     redirect_to restaurant_path(@restaurant.id) and return
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
