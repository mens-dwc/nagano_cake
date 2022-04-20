class Admin::ItemsController < ApplicationController
  def index #admin_items_path
    @items=Item.all
  end

  def show #admin_item
    @item=Item.find(params[:id])
  end

  def new #new_admin_item
     @item=Item.new
  end

  def create #admin_items_path
     @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def edit #edit_admin_item
      @item=Item.find(params[:id])
  end

  def update #admin_item
      @item=Item.find(params[:id])
  end
end
