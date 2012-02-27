# coding: utf-8
require 'rubygems'

class FortyTwo < Sinatra::Base
  Time.zone = 'Berlin'
  # All Controllers receiving requests, 
  # to reduce file size of the main file
  register Sinatra::Timetrackings
  register Sinatra::Worklets
  
  configure :development do
    #register Sinatra::Reloader
  end
  
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "public") }
  set :views, Proc.new { File.join(root, "views") }
  use Rack::Session::Cookie, :key => 'fortytwo_session', :path => '/', 
    :expire_after => 600*60,
    :secret => '859375824hjgr2hf21cq2gr387rgqckegc32gruze12e87gezcfcqwhdvqgc12xc321ffihgrchsdvqwez'
  
  before do
    if !session[:user] && !['/login','/authenticate','/logout'].include?(request.env['REQUEST_PATH'])
      redirect to('/login') and return
      #throw :halt, [401, 'authentication key is not valid']
    end
  end
  
  get '/' do
    @users = User.all
    @worklets = Worklet.all
    
    erb :index, :charset => "utf-8"
  end
    
  get '/roadmap' do
    @users = User.all
    @worklets = Worklet.all
    
    erb :roadmap, :charset => "utf-8"
  end
  
  post '/elements/save' do
    content_type :json
    
    params[:worklet][:user] = session[:user]
    
    Worklet.create(params[:worklet])
    
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
    session[:user] = params[:user].downcase
    user = User.find(params[:user])
    if not user
      User.create(:_id => session[:user], :name => params[:user])
    end
    
    redirect to('/')
  end
  
  not_found do
    
    erb "404"
  end
  
  helpers do
    def basic_errors(incoming)
      
    end
  end

end