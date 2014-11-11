class CreateQueryResults < ActiveRecord::Migration
  def change
    create_table :query_results do |t|
      t.references :query, index: true
      t.integer :position
      t.integer :previous_position
      t.timestamp :last_updated

      t.timestamps
    end
  end
end
