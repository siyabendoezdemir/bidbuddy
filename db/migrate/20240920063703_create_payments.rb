class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :auction, foreign_key: true
      t.references :buyer, foreign_key: { to_table: :accounts }
      t.decimal :amount
      t.string :status
      t.datetime :timestamp

      t.timestamps
    end
  end
end
