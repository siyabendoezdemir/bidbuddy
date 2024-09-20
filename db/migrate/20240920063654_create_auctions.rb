class CreateAuctions < ActiveRecord::Migration[6.1]
  def change
    create_table :auctions do |t|
      t.references :item, foreign_key: true
      t.datetime :startTime
      t.datetime :endTime
      t.decimal :currentPrice
      t.string :status

      t.timestamps
    end
  end
end
