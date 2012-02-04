# coding: utf-8
class User
  include MongoMapper::Document
  
  key :name,  String
  
  timestamps!
  
end
