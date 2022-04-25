class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum item_status: {"着手不可": 0,"製作待ち": 1,"制作中": 2, "製作完了": 3}
  
  after_update do
    ordered_items = self.order.ordered_items
    if ordered_items.any? {|ordered_item| ordered_item.item_status == "製作中"} == true # 条件分岐：製作ステータスが1つでも製作中にだったら
      self.order.update(order_status: "製作中") # 注文ステータスを製作中に変更する
    elsif ordered_items.all? {|ordered_item| ordered_item.item_status == "製作完了"} == true # 条件分岐：製作ステータスが全て製作完了だったら
    self.order.update(order_status: "発送準備中") # 注文ステータスを発送準備中に変更する
    end
  end
end
