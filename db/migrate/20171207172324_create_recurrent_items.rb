class CreateRecurrentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :recurrent_items do |t|
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
