class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :domain, index: true
      t.references :search_engine, index: true
      t.string :word

      t.timestamps
    end
  end
end
