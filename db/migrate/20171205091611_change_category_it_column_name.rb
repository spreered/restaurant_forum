class ChangeCategoryItColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :restaurants, :catagory_id, :category_id
  end
end
