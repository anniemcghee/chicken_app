class CreateChickens < ActiveRecord::Migration
  def change
    create_table :chickens do |t|
      t.string :name
      t.string :breed
      t.string :desc

      t.timestamps
    end
  end
end
