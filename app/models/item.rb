class Item < ApplicationRecord

  has_one_attached:image

  has_many :cart_items,dependent: :destroy
  has_many :ordered_items,dependent: :destroy
  #税込み価格
 def with_tax_price
    (price * 1.1).floor
 end

end
