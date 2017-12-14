class AddRecurrentItemToItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :recurrent_item, foreign_key: true
  end
end
