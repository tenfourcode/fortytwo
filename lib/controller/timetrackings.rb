# coding: utf-8
# Handles all Timetracking requests
module Sinatra
  module Timetrackings
    
    def self.registered(app)
      
      app.before '/timetracking*' do
        @current_page = '/timetracking'
      end
      
      app.get '/timetracking' do
        @users = User.all
        @worklets = Worklet.all
        
        @tasks = Task.all
        
        erb :timetracking, :charset => "utf-8"
      end
      
      app.get "/timetracking/:user" do
        @users = User.all
        @worklets = Worklet.all
    
        @tasks = Task.where(:user => params[:user])
    
        erb :timetracking, :charset => "utf-8"
      end
  
      app.post '/task/create' do
        content_type :json
        
        task = Task.new(params[:task])
        task.user       = session[:user]
        
        # Not the best solution, needs improvement, soon!
        if params[:task][:start_time].length < 6
          task.start_time = params[:task][:start_time]
          task.end_time   = params[:task][:end_time]
        else
          task.start_time = Time.at(params[:task][:start_time].to_i / 1000)
          task.end_time   = Time.at(params[:task][:end_time].to_i / 1000)
        end
        task.save
        
        task.to_json
      end
      
    end
  end
  register Timetrackings
  
end