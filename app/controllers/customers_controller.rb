class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.where(role: :customer)
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
    @bookings = @customer.bookings.where(booked: true)
  end

  def destroy
    if @customer.destroy
      flash[:notice] = "Customer deleted"
    else
      flash[:alert] = "Could not delete customer"
      redirect_to customers_path
    end
  end

  private

  def set_user
    @customer = Customer.find(params[:id])
  end
end
