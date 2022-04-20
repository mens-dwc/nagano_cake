class Public::OrdersController < ApplicationController
  def new
  end

  def comfirm
  end

  def create
  end

  def finish
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @orders.ordered_items
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_type, :total_payment)
  end

end
