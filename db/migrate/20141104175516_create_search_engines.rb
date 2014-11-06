class CreateSearchEngines < ActiveRecord::Migration
  def change
    create_table :search_engines do |t|
      t.string :engine

      t.timestamps
    end
  end
end
