class CreateKashflows < ActiveRecord::Migration[5.1]
  def change
    create_table :kashflows do |t|
      t.integer :year

      t.timestamps
    end
  end
end
