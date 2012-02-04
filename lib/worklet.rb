# coding: utf-8
class Worklet
  include MongoMapper::Document
  
  key :user,              String
  key :title,             String
  key :description,       String
  key :tags,              Array
  key :estimated_release, Date
  key :actual_release,    Date
  
  timestamps!
  
  
end
