class ChangeColumnPostalCode < ActiveRecord::Migration[6.1]
  def change
    change_column :addresses, :postal_code, :string
  end
end
