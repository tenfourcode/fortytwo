# coding: utf-8
class Task
  include MongoMapper::Document
  
  key :user,        String
  key :start_time,  Time
  key :end_time,    Time
  key :text,        String
  key :tags,        Array
  key :duration,    Integer
  
  timestamps!
  
  attr_accessible :text
  
  def duration
    self.end_time.to_i - self.start_time.to_i
  end
    
end
