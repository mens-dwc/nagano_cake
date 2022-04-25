class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items.all
  end
  
  def order_status_update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order)
  end
  
  def item_status_update
    ordered_item = OrderedItem.find(params[:id])
    ordered_item.update(ordered_item_params)
    redirect_to admin_order_path(ordered_item.order_id)
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end

  def ordered_item_params
    params.require(:ordered_item).permit(:item_status)
  end
end
