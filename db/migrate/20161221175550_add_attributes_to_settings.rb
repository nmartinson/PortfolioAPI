class AddAttributesToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :dealer_cost, :float
    add_column :settings, :dealer, :string
    add_column :settings, :has_free_shipping, :boolean
  end
end
