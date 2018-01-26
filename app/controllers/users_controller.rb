class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:user][:name],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
      role_id: params[:user][:role]
    )

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
    @reservations = @user.reservations
    @restaurants = @user.restaurants
    @owned_reservations = []
    @customers = []
    @restaurants.each {|restaurant|
      restaurant.reservations.each {|reservation|
        @owned_reservations << reservation
        if reservation.user.loyalty_points != nil
         @customers << reservation.user
        end
      }
    }
    if @customers.any? && (@customers.count > 1)
      @customers.uniq!.sort_by!(&:loyalty_points).reverse!
    else
      @customers.sort_by!(&:loyalty_points)
    end
    @reservations_within_week = []
    @owned_reservations.each {|reservation|
      if reservation.time.to_f < (Time.now + 1.week).utc.to_f
        @reservations_within_week << reservation
      end
    }
  end

end
