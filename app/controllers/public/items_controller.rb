class Public::ItemsController < ApplicationController
  #ログインユーザーのみproduct#indexは閲覧可

  def index #items_path
    @items=Item.page(params[:page]).per(4)
    @itemss =Item.where(is_status: 'false')
    @genres = Genre.all
    #Denreのshow  genre_path
  end

  def show #item_path(item.id)
   @item=Item.find(params[:id])
   @cart_item=CartItem.new
  end

end
