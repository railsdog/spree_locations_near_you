class CreateSpreeVenue < ActiveRecord::Migration
  def change
    create_table :spree_venues do |t|
      t.string :name, null: false
      t.string :venue_hours
      t.string :store_code
      t.string :address
      t.string :rank, default: "sliver"
      t.string :phone
      t.string :street_address
      t.string :city
      t.string :country
      t.string :phone
      t.string :state
      t.string :website
      t.string :zip
      t.string :letter
      t.float :latitude
      t.float :longitude
      t.boolean :hidden, null: false, default: false
      t.timestamps
    end
  end
end
