class AddAdminMessageToAuctions < ActiveRecord::Migration[7.0]
  def change
    add_column :auctions, :admin_message, :text
  end
end
