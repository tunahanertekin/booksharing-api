class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :title
      t.integer :bookAmount
      t.integer :buy
      t.integer :sell
      t.decimal :score

      t.timestamps
    end
  end
end
