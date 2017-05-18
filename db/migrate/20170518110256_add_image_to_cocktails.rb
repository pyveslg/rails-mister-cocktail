class AddImageToCocktails < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :img, :string
  end
end
