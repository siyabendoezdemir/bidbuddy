class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.references :auction, foreign_key: true
      t.references :bidder, foreign_key: { to_table: :accounts }
      t.decimal :amount
      t.datetime :timestamp

      t.timestamps
    end
  end
end
