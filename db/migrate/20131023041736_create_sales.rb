class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :number_of_sales, default: 0, null: false
      t.string  :state, null: false
    end
  end
end
