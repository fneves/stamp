class CreateStampRateTypes < ActiveRecord::Migration
  def change
    create_table :stamp_rate_types do |t|
      t.string :description
      t.string :period_duration
      t.timestamps
    end

    create_table :stamp_time_slots do |t|
      t.belongs_to :reservation
      t.belongs_to :service
      t.datetime :from
      t.integer :unit
      t.references :rate_type
      t.timestamps
    end

  end
end
