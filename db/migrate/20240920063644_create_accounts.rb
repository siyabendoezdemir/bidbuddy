class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.string :displayName
      t.string :email
      t.string :password
      t.string :role

      t.timestamps
    end
  end
end
