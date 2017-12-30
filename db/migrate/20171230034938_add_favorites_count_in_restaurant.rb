class AddFavoritesCountInRestaurant < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :favorites_count, :integer
  end
end
