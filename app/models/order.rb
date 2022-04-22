class Order < ApplicationRecord
  enum payment_type: { credit_card: 0, transfer: 1 }
end
