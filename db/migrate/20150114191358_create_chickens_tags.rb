class CreateChickensTags < ActiveRecord::Migration
  def change
    create_table :chickens_tags do |t|
      t.references :chicken, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
