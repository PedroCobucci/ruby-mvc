class CreateProdutos < ActiveRecord::Migration[7.0]
  def change
    create_table :produtos do |t|
      t.integer :ean
      t.integer :sku
      t.string :descricao
      t.string :fabricante

      t.timestamps
    end
  end
end
