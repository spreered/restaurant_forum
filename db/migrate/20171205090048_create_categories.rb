class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
  end
  add_column :restaurants, :catagory_id, :integer
  
end
