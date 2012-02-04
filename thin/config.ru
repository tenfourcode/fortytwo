#coding: utf-8
require 'tzinfo'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader'

$LOAD_PATH << '../lib'

require 'redis'
$redis = Redis.new()
require 'json'
require 'mongo'
require 'mongo_client'
require 'mongo_mapper'
require 'nokogiri'
require 'constants'

MongoMapper.connection = Mongo::Connection.new(Constants.mongo_host, Constants.mongo_port, :pool_size => 5, :pool_timeout => 5)
MongoMapper.database = Constants.mongo_db

# Models
require 'task'
require 'user'
require 'worklet'
require 'comment'

# Controller
require 'controller/timetrackings'
require 'controller/worklets'

require 'forty_two'


run FortyTwo