class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :value

      t.timestamps null: false
    end
  end
end
