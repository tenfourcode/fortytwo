# coding: utf-8
require 'rubygems'

class FortyTwo < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public, Proc.new { File.join(root, "public") }
  set :views, Proc.new { File.join(root, "views") }
  use Rack::Session::Cookie, :key => 'fortytwo_session', :path => '/', 
        :expire_after => 360,
        :secret => '859375824hjgr2hf21cq2gr387rgqckegc32gruze12e87gezcfcqwhdvqgc12xc321ffihgrchsdvqwez'
  
  before '/' do
   unless session[:user]
     redirect to('/login') and return
     #throw :halt, [401, 'authentication key is not valid']
   end
  end
  
  get '/' do
    
    erb :index, :charset => "utf-8"
  end
  
  post '/elements/save' do
    content_type :json
    client = Riak::Client.new
    bucket = client.bucket("fortytwo")  # a Riak::Bucket
    new_one = Riak::RObject.new(bucket)
    new_one.content_type = "application/json" # You must set the content type.
    
    obj_hash = {'owner' => 'Daniel'}
    params['keyvalue'].each { |key,param|
      obj_hash[param['key']] = param['value']
    }
    new_one.data = obj_hash
    new_one.store
    
    "{key:#{new_one.key}}".to_json
  end
  
  post '/search' do
    content_type :json
    client = Riak::Client.new :solr => "/solr"
    result = client.search("fortytwo","owner:#{params[:search]}*")
    
    result['response']['docs'].to_json
  end
  
  get '/login' do
    
    erb :login, :layout => false
  end
  
  post '/authenticate' do
    session[:user] = params[:user]
    
    redirect to('/')
  end
  
  not_found do
    
    erb "404"
  end
  
  helpers do
    def basic_errors(incoming)
      
    end
    
    def valid_item?(item)
      
    end
  end

end