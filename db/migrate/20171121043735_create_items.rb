class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :trx_type
      t.date :trx_date
      t.float :amount
      t.string :name

      t.timestamps
    end
  end
end
