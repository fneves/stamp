# This migration comes from stamp (originally 20131103141753)
class CreateStampServices < ActiveRecord::Migration
  def change
    create_table :stamp_services do |t|
      t.integer :owner_id
      t.string :name
      t.integer :opening_hours
      t.integer :closing_hours
      t.string :external_id
      #Period size in minutes
      t.integer :period_size
      t.references :service_type
      t.integer :payment_method
      t.timestamps
    end
    add_reference :stamp_service_types, :service_type, index: true
  end
end
