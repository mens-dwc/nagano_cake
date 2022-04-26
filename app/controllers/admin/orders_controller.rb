class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items.all
    @items_total_price = calculate(@order)
  end

  def calculate(items_total_price) # 商品合計を算出するメソッド
    @items_total_price = 0
    @ordered_items.each {|ordered_item|
    tax_in_price = (ordered_item.taxed_price).floor
    sub_total_price = tax_in_price * ordered_item.quantity
    @items_total_price += sub_total_price
    }
    return @items_total_price
  end

  def order_status_update
    order = Order.find(params[:id])
    if order.update(order_params)
      redirect_to admin_order_path(order)
      flash.now[:notice] = "注文ステータスを更新しました"
    else
      render :show
      flash.now[:notice] = "注文ステータスを更新できませんでした"
    end
  end

  def item_status_update
    ordered_item = OrderedItem.find(params[:id])
    if ordered_item.update(ordered_item_params)
      redirect_to admin_order_path(ordered_item.order_id)
      flash.now[:notice] = "製作ステータスを更新しました"
    else
      render :show
      flash.now[:notice] = "製作ステータスを更新できませんでした"
    end
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

  def ordered_item_params
    params.require(:ordered_item).permit(:item_status)
  end
end
