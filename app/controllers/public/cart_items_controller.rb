class Public::CartItemsController < ApplicationController

  def index #cart_items_path
   @cart_items=current_customer.cart_items.all
   #@cart_items=CartItem.all
   #カートに入っている商品の合計
   @total=@cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create #cart_items_path post
    cart_item=CartItem.new(cart_item_params)
    cart_item.customer_id=current_customer.id
  
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
                    #元々カート内にあるもの「item_id」　
                    #今追加した　　　　　　　params[:cart_item][:item_id])
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      #cart_item.quantityに今追加したparams[:cart_item][:quantity]を加える
                                                        #.to_iとして数字として扱う
      cart_item.save
      redirect_to cart_items_path
  # もしカート内に「同じ」商品がない場合は通常の保存処理 
    elsif cart_item.save
          　@cart_items = current_member.cart_items.all
          　render 'index'
    else　# 保存できなかった場合
          render 'index'
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
    cart_item=CartItem.find(params[:id])
    cart_item.customer_id=current_customer.id
    cart_item.destroy
    flash[:alert] = "カートの商品を削除しました"
    redirect_to cart_items_path
  end

  def all_destroy #all_destroy_cart_items
    cart_item=current_customer.cart_items
    cart_item.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
  end

end