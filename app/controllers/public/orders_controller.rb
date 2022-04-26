class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new #注文入力
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def comfirm #注文確認
    params[:order][:payment_type] = params[:order][:payment_type].to_i #payment_methodの数値に変換
    @order = Order.new(order_params)
    
    
        #支払い方法のセッション情報
    if params[:payment_select] == "0"
      session[:user][:payment_type] = 0
    elsif params[:payment_select] == "1"
      session[:user][:payment_type] = 1
    end


    if params[:order][:address_option] == "0" #cutomerの登録時の住所
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1" #登録済み住所
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name
    elsif params[:order][:address_option] = "2" #新規住所登録
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
      @cart_items = current_customer.cart_items.all
      @order.customer_id = current_customer.id
  end


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @ordered_item = OrderedItem.new #初期化宣言
      @ordered_item.item_id = cart_item.item_id #商品idを注文商品idに代入
      @ordered_item.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
      @ordered_item.taxed_price = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
      @ordered_item.order_id =  @order.id #注文商品に注文idを紐付け
      @ordered_item.save #注文商品を保存
    end #ループ終わり
    current_customer.cart_items.destroy_all
    redirect_to orders_finish_path

  end

  def finish
  end

  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_type, :total_payment, :order, :postage, :customer_id, :status)
  end

end
