# coding: utf-8
require 'rubygems'

class FortyTwo < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "public") }
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
    client = MongoClient.connection.collection(Constants.coll_timetracking)
    
    obj_hash = {'owner' => session[:user]}
    params['keyvalue'].each { |key,param|
      obj_hash[param['key']] = param['value']
    }
    
    client.insert(obj_hash)
    
    {:key => 'ok'}.to_json
  end
  
  post '/search' do
    content_type :json
    client = MongoClient.connection.collection(Constants.coll_timetracking)
    search_text = params[:search]
    result = client.find(:title => /^#{search_text}/i)
    
    result.to_a.to_json
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