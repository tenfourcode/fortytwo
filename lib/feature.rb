# coding: utf-8
class Feature
  include MongoMapper::Document
  
  key :title,             String
  key :identifier,        String
  key :estimated_release, Date
  key :actual_release,    Date
  timestamps!
  
  
end
