class Admin::MakingStatusesController < ApplicationController
  def update
    @ordered_items = OrderedItem.find(params[:id])
    if @ordered_items.update(ordered_items_params)
      flash[:success] = "制作ステータスを変更しました"
      redirect_to admin_order_path(@ordered_items.order)
    else
      # @ordered_items = OrderedItems.find(params[:id])
      render 'show'
    end
  end

  private

  def ordered_items_params
    params.require(:ordered_item).permit(:making_status)
  end
end
