class Admin::ItemsController < ApplicationController


  def new #new_admin_item
     @newitem=Item.new
  end

  def create #admin_items_path
     @newitem = Item.new(item_params)
    if @newitem.save
      redirect_to admin_items_path
    else
      render :new
    end
  end


  def index #admin_items_path
    @items=Item.all
  end

  def show #admin_item
    @item=Item.find(params[:id])
  end


  def edit #edit_admin_item
      @item=Item.find(params[:id])
  end

  def update #admin_item
      @item=Item.find(params[:id])
      if @item.update(item_params)
      redirect_to admin_items_path
      end
  end

 private

  def item_params
    params.require(:item).permit(:image,:name,:introduction,:genre_id,:price,:is_status)
  end
end
