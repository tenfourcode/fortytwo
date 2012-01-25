# coding: utf-8
require 'rubygems'

class FortyTwo < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "public") }
  set :views, Proc.new { File.join(root, "views") }
  use Rack::Session::Cookie, :key => 'fortytwo_session', :path => '/', 
        :expire_after => 3600,
        :secret => '859375824hjgr2hf21cq2gr387rgqckegc32gruze12e87gezcfcqwhdvqgc12xc321ffihgrchsdvqwez'
  
  before '/' do
   unless session[:user]
     redirect to('/login') and return
     #throw :halt, [401, 'authentication key is not valid']
   end
  end
  
  get '/' do
    @users = User.all
    @features = Feature.all
    
    erb :index, :charset => "utf-8"
  end
  
  get '/timetracking' do
    @users = User.all
    @features = Feature.all
    
    erb :timetracking, :charset => "utf-8"
  end
  
  get '/roadmap' do
    @users = User.all
    @features = Feature.all
    
    erb :roadmap, :charset => "utf-8"
  end
  
  get '/features' do
    @users = User.all
    @features = Feature.all
    
    erb :features, :charset => "utf-8"
  end
  
  post '/elements/save' do
    content_type :json
    
    Feature.create(params[:feature])
    
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
  
  get '/logout' do
    session.clear
    
    redirect to('/')
  end
  
  post '/authenticate' do
    session[:user] = params[:user]
    user = User.where(:name => params[:user]).first
    if not user
      User.create(:name => params[:user])
    end
    
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