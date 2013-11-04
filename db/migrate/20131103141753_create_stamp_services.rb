class CreateStampServices < ActiveRecord::Migration
  def change
    create_table :stamp_services do |t|
      t.string :name
      t.references :service_type
      t.string :external_id
      t.timestamps
    end
  end
end
