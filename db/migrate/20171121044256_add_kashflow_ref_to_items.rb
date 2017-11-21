class AddKashflowRefToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :kashflow, foreign_key: true
  end
end
