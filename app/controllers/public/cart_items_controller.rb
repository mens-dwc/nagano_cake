class Public::CartItemsController < ApplicationController
  def index #cart_items_path
   @cart_items=current_customer.cart_items
   @total_price+=@cart_items.subtotal 
  end
  
  def create #cart_items_path post
   @cart_item=CartItem.find_by(item_id)
   @cart_item.customer_id=current_customer.id
   @cart_item.save
   
  end
  
  def update #cart_item_path
  end
  
  def destroy #cart_item_path
    @cart_item=CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def all_destroy
    @cart_itmes=current_user.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
  end
