class RemoveSthFromExchanges < ActiveRecord::Migration[6.0]
  def change

    remove_column :exchanges, :isPending, :boolean

    remove_column :exchanges, :isAccepted, :boolean
  end
end
