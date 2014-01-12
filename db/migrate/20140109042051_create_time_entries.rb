class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :task, index: true

      t.timestamps
    end
  end
end
