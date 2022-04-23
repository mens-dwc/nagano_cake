class Public::CartItemsController < ApplicationController

  def index #cart_items_path
   @cart_items=current_customer.cart_items
   #@cart_items=CartItem.all
   #@total_price+=@cart_items.subtotal
  end

  def create #cart_items_path post
     @cart_item=CartItem.new(cart_item_params)
     @cart_item.customer_id=current_customer.id
     if @cart_item.save
     redirect_to cart_items_path
     end
  end

  def update #cart_item_path patch put
     @cart_item=CartItem.new(cart_item_params)
     #@cart_item.customer_id = current_customer.id
     #@cart_item.item_id=cart_item_params[:item_id]
     if @cart_item.update
     redirect_to cart_items_path
     else
     render :index
     end
  end

  def destroy #cart_item_path delete
    @cart_item=CartItem.find(params[:id])
    @cart_item.customer_id=current_customer.id
   if @cart_item.destroy
    redirect_to cart_items_path
   end
  end

  def all_destroy #all_destroy_cart_items
    @cart_itmes=current_user.cart_items
    @cart_itmes.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
  end

end