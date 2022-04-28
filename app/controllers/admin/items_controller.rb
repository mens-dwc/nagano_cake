class Admin::ItemsController < ApplicationController
before_action :authenticate_admin!

  def new #new_admin_item
     @item=Item.new
  end

  def create #admin_items_path
     @item =Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index #admin_items_path
    @items=Item.page(params[:page]).per(10)
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
      else
      render:show
      end
  end

 private

  def item_params
    params.require(:item).permit(:image,:name,:introduction,:genre_id,:price,:is_status)
  end
end
