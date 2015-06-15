class CreateSpreeVenue < ActiveRecord::Migration
  def change
    create_table :spree_venues do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
