class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      # t.references :recipes, foreign_key: true
      # t.references :foods, foreign_key: true
      t.integer :quantity
      t.references :recipe, null: false, foreign_key: { to_table: :recipes }
      t.references :food, null: false, foreign_key: { to_table: :foods }
      t.timestamps
    end
  end
end
