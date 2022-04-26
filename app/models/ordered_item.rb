class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum item_status: {
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
    ordered_items = self.order.ordered_items
    if ordered_items.any? {|ordered_item| ordered_item.item_status == 2 } == true # 条件分岐：製作ステータスが1つでも製作中にだったら
      self.order.update(order_status: 2 ) # 注文ステータスを製作中に変更する
    elsif ordered_items.all? {|ordered_item| ordered_item.item_status == 3 } == true # 条件分岐：製作ステータスが全て製作完了だったら
    self.order.update(order_status: 3 ) # 注文ステータスを発送準備中に変更する
    end
  end
end
