class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :keyword
      t.references :campaign, index: true
      t.references :search_engine, index: true

      t.timestamps
    end
  end
end
