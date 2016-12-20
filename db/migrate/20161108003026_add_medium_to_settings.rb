class AddMediumToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :medium, :string
  end
end
