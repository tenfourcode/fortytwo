#coding: utf-8
require 'bundler/setup'
require 'sinatra'

$LOAD_PATH << '../lib'

require 'redis'
$redis = Redis.new()
require 'json'
require 'mongo'
require 'mongo_client'
require 'nokogiri'
require 'constants'
require 'forty_two'

run FortyTwo