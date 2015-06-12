class EnablePostgresEarthDistance < ActiveRecord::Migration
  def change
    enable_extension 'cube'
    enable_extension 'earthdistance'
  end
end
