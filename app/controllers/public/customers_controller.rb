class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = Address.find(params[:id])
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end
end
