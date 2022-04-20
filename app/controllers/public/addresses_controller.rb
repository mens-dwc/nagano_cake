class Public::AddressesController < ApplicationController
  #before_action :authenticate_customer!
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @addresses = Address.new(address_params)
    @addresses.customer_id = current_customer.id
    if @addresses.save
      redirect_to addresses_path#(@addresses)
    else
      @addresses = Address.all
      render 'index'
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to address_path(@address.id)
    else
      @address = Address.all
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path#(@addresses)
  end
  
  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name )
  end

end
