class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items
  has_many :items, through: :ordered_items 
  
  enum payment_type: { credit_card: 0, transfer: 1 }
end
