class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.decimal :startingPrice
      t.references :seller, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
