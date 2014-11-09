class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.references :domain, index: true

      t.timestamps
    end
  end
end
