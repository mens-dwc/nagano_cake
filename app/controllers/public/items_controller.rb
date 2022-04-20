class Public::ItemsController < ApplicationController
  #ログインユーザーのみproduct#indexは閲覧可
 
  def index #items_path
    @items=Item.all
  end

  def show #item_path(item.id)
   @item=Item.find(params[:id])
   
  end
end
