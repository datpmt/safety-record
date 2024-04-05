class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|

      t.timestamps
      t.integer :quantity
    end
  end
end
