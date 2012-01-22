# coding: utf-8
require 'mongo'
require 'json'

class MongoClient
  
  def self.connection
    @@connection ||= Mongo::Connection.new(Constants.mongo_host, Constants.mongo_port, :pool_size => 5).db(Constants.mongo_db)
  end

  def self.connection=(new_connection)
    @@connection = new_connection
  end  
  
end
