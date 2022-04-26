class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items
  has_many :items, through: :ordered_items

  validates :name, :postal_code, :address, presence:true

  enum payment_type: { credit_card: 0, transfer: 1 }
  
  # 注文ステータス（0=支払待ち / 1=支払済み / 2制作中 / 3=発送準備中 / 4=発送済み）
  enum order_status: {
      waiting: 0,
      paid_up: 1,
      making: 2,
      preparing: 3,
      shipped: 4
  }

  def address_name
    postal_code + address + name
  end

  after_update do
    if self.order_status == "入金確認" #入金確認の更新があった時
      self.ordered_items.each {|ordered_item|
      ordered_item.update(item_status: "製作待ち") #製作ステータスを製作待ちに変更する
      }
    end
  end
end
