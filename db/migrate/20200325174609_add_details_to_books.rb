class AddDetailsToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :imageSource, :string
  end
end
