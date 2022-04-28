class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {
    no_making: 0,
    make_waiting: 1,
    making: 2,
    making_complete: 3
  }

  #税込み価格＊個数
  def subtotal
    item.with_tax_price*quantity
  end

  after_update do
    if self.order.ordered_items.exists?(making_status: 2 )
      self.order.update(status: 2 ) # 注文ステータスを製作中に変更する
    elsif self.order.ordered_items.where(making_status: 3 ).count == self.order.ordered_items.count
      self.order.update(status: 3 ) # 注文ステータスを発送準備中に変更する
    end
  end
end
