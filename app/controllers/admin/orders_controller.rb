class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items.all
  end
  
  def update
  end
end
