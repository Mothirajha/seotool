class AddUrlToQueryResult < ActiveRecord::Migration
  def change
    add_column :query_results, :url, :string
  end
end
