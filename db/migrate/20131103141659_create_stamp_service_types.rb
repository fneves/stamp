class CreateStampServiceTypes < ActiveRecord::Migration
  def change
    create_table :stamp_service_types do |t|
      t.string :name
      t.references :rate_type
      t.timestamps
    end
  end
end
