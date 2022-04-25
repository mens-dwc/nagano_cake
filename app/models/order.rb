class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items
  has_many :items, through: :ordered_items

  validates :name, :postal_code, :address, presence:true

  enum payment_type: { credit_card: 0, transfer: 1 }
  enum order_status: {"入金待ち": 0,"入金確認": 1,"製作中": 2,"発送準備中": 3, "発送済み": 4}

  def self.address_name(user)
    user.postal_code + user.address
  end
  
  after_update do
    if self.order_status == "入金確認"
      self.ordered_items.each {|ordered_item|
      ordered_item.update(item_status: "製作待ち")
      }
    end
  end
end
