class ReservationsController < ApplicationController

  before_action :new_reservation, only: [:new, :create]
  before_action :load_restaurant, only: [:show, :new, :create]

  def show
  end

  def new
  end

  def create
    @reservation = Restaurant.new(reservation_params)
    if @reservation.save
      flash[:notice] = "Reservation successfully booked"
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
    params.require(:reservation).permit(:time, :party_size, :restaurant)
  end
end