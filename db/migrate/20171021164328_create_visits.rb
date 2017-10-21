class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :country
      t.datetime :visited_at
      t.decimal :load_time

      t.timestamps
    end
  end
end
