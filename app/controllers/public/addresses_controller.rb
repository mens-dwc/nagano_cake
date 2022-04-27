class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = current_customer.address
    if @address.save
      flash.now[:notice] = "新しい配送先を登録しました"
      redirect_to addresses_path#(@addresses)
    else
      @addresses = current_customer.address
      render 'index'
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path#(@address.id)
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
