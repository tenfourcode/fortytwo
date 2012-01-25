#coding: utf-8
require 'bundler/setup'
require 'sinatra'

$LOAD_PATH << '../lib'

require 'redis'
$redis = Redis.new()
require 'json'
require 'mongo'
require 'mongo_client'
require 'mongo_mapper'
require 'nokogiri'
require 'constants'
require 'forty_two'

MongoMapper.connection = Mongo::Connection.new(Constants.mongo_host, Constants.mongo_port, :pool_size => 5, :pool_timeout => 5)
MongoMapper.database = Constants.mongo_db

# Models
require 'user'
require 'feature'


run FortyTwo