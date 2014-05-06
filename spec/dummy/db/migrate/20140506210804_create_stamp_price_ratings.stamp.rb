# This migration comes from stamp (originally 20131103141711)
class CreateStampPriceRatings < ActiveRecord::Migration
  def change
    create_table :stamp_price_ratings do |t|
      t.belongs_to :service
      t.datetime :from
      t.datetime :to
      t.decimal :value
      t.timestamps
    end
  end
end
