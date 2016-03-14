# This is used by Rake for migration

require 'active_record'
require 'sqlite3'
require 'mysql2'
require 'logger'

ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['production'])

class User < ActiveRecord::Base
end
