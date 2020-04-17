class RemoveLastRequestFromExchanges < ActiveRecord::Migration[6.0]
  def change

    remove_column :exchanges, :lastRequest, :integer
  end
end
