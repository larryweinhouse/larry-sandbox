BASE_PATH = File.expand_path('../',File.dirname(__FILE__))

require 'gmail'
require 'csv'
require 'set'
require 'active_record'
require 'active_support/all'
require 'mysql2'
require 'uuidtools'

INSTALLED_GEM_MODE = BASE_PATH.include?("/gems/")

ENV['BUNDLE_GEMFILE'] = BASE_PATH + '/Gemfile'
ENV['ENV']||='production'

unless INSTALLED_GEM_MODE
    require 'bundler'
      Bundler.setup
end

require "#{BASE_PATH}/lib/version"
require "#{BASE_PATH}/lib/loader"

require "#{BASE_PATH}/models/telemetry"
require "#{BASE_PATH}/models/load_log"

LOADERS=%w[base_loader telemetry_loader]

LOADERS.each do |l|
     require "#{BASE_PATH}/lib/loaders/#{l}"
end
