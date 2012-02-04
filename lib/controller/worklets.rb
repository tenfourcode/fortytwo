# coding: utf-8
# Handles all Timetracking requests
module Sinatra
  module Worklets
    
    def self.registered(app)
      
      app.before '/worklets*' do
        @current_page = '/worklets'
      end
      
      app.get '/worklets' do
        @users = User.all
        @worklets = Worklet.all
    
        erb :worklets, :charset => "utf-8"
      end
      
      app.get '/worklets/:user' do
        @users = User.all
        @worklets = Worklet.where(:user => params[:user])
    
        erb :worklets, :charset => "utf-8"
      end
      
    end
  end
  register Worklets
  
end