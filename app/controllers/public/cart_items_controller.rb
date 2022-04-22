class Public::CartItemsController < ApplicationController

    # カート商品一覧を表示
    def index #cart_items_path
        @cart_items = cart_items
        @total_price = @cart_items.sum{|cart_item|cart_item.item.with_tax_price * cart_item.quantity }
        # sumメソッド：合計金額を出す
        # 1行目の@cart_itemsにsumメソッドを用いて{}の||ブロック変数にcart_itemを代入している。(each do || end の文章と同じイメージ)
        # cart_item.item.price_without_tax：アソシエーションしているのでドットでつなげる。
        # 『このcart_itemのitemのprice_without_tax』 → 『このカート商品の商品（単体）の税抜き価格』
        # cart_item.quantity：『このカート商品の個数』
    end


    # カート商品を追加する
    def create #cart_items_path
        # @cart_item = current_customer.cart_items.build(item_id: params[:item_id])
        @cart_item = CartItem.new
        @cart_item.customer_id = current_customer.id
        @cart_item.item_id = params[:item_id]
        # byebug

        if @cart_item.save
           flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
           redirect_to cart_items_path
        else
            flash[:alert] = "個数を選択してください"
            render "public/cart_items/index"
        end
    end


    def update #cart_item_path
      @cart_item = CartItem.find(params[:id])
      #@cart.units += cart_params[:units].to_i
      @cart_item.update(cart_item_params)
      redirect_to customers_cart_items_path
    end


    # カート商品を一つのみ削除
    def destroy #cart_item_path
      @cart_item=CartItem.find(params[:id])
      @cart_item.current_customer.cart_items.destroy_all
      redirect_to cart_items_path
    end

   # カート商品を空ににする
    #def all_destroy
        #@cart_item = current_customer.cart_items
        #@cart_item.destroy_all
        #flash[:alert] = "カートの商品を全て削除しました"
        #redirect_to customers_cart_items_path
    #end

  private

    def cart_item_params
      params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
    end

end
