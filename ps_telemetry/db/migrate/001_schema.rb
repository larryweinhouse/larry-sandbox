class Schema < ActiveRecord::Migration
  def change
    create_table :telemetries, {force: true, id: false} do |t|
      t.string   :id, limit: 36
      t.string   :partner, limit: 50
      t.string   :outpost_application, limit: 30
      t.string   :group_id
      t.integer  :requests, :limit => 8
      t.integer  :hits, :limit => 8
      t.date     :date
    end
    add_index :telemetries, :id, :unique=>true
    add_index :telemetries, :partner
    add_index :telemetries, :outpost_application
    add_index :telemetries, :group_id
    add_index :telemetries, :date

    create_table    :load_logs, {force: true} do |t|
      t.timestamp   :created_at
      t.timestamp   :email_date
      t.string      :loader, :limit=>64
      t.integer     :new_lines, default: 0
      t.integer     :duplicate_lines, default: 0
      t.integer     :line_errors, default: 0
      t.integer     :attachments, default: 0
    end
    add_index :load_logs, :loader
  end
end
