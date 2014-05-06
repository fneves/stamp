# This migration comes from stamp (originally 20131103141659)
class CreateStampServiceTypes < ActiveRecord::Migration
  def change
    create_table :stamp_service_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
