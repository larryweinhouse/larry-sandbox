class Telemetry < ActiveRecord::Base

  self.primary_key=:id
  
  KEY_COLUMNS=[
    :partner,
    :outpost_application,
    :group_id,
    :requests,
    :hits,
    :date
  ]

before_save :set_id

  #this generates a hash of the KEY_COLUMN values that represent a unique row -- this hash is used to produce a uuid as the row id
  def self.generate_id(key_cols)
    UUIDTools::UUID.sha1_create(UUIDTools::UUID_OID_NAMESPACE, key_cols.join('-')).to_s
  end

  def set_id
    self.id||=Telemetry.generate_id(KEY_COLUMNS.map{|c| send(c)})
  end

end
