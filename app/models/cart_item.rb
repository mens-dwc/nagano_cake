class CartItem < ApplicationRecord

  belongs_to:customer
  belongs_to:item


#税込み価格＊個数
  def subtotal
    item.with_tax_price*quantity
  end

end
