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
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.restaurant_id = params[:restaurant_id]
    if @reservation.validates_reservation.any?
      @reservation.validates_reservation.each {|error|
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
