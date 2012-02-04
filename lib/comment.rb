# coding: utf-8
class Comment
  include MongoMapper::Document
  
  key :user,  String
  key :text,  String
  key :tags,  Array
  
  timestamps!
  
  
  
#  
#  # Comment
#  {
#    :text => 'Es fehlt noch.',
#    :user => 'Daniel',
#    :tags => ['report-builder','import-api'],
#    :created_at => ''
#  }

  
end
