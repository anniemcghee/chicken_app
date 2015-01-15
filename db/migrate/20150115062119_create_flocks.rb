class CreateFlocks < ActiveRecord::Migration
  def change
    create_table :flocks do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
