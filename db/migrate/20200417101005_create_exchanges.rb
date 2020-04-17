class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :toUser
      t.text :booksOffered
      t.text :booksWanted
      t.boolean :isPending
      t.boolean :isAccepted
      t.integer :lastRequest

      t.timestamps
    end
  end
end
