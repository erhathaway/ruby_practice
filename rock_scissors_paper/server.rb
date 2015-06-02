require "sinatra"
require_relative "game"
require 'pry'
require "openssl"


set :sessions, true

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"

}

get '/' do
  redirect '/form'
end

get '/form' do
  if  session[:player_score] == nil || session[:computer_score] == nil
    session[:player_score]=0
    session[:computer_score]=0
    session[:message]=['Welcome!', "",""]
    session[:computer_games]=0
    session[:player_games]=0

  end

  erb :'form'
end

post '/form/answer' do

  answer = params['answer']

  if answer == nil
    session[:message]= ['You forgot to choose a tool you fool',"",""]
    redirect '/form'
  end
  result = play(answer, session[:player_score], session[:computer_score])
  if result[0] == nil
    session[:player_score]=result[2]
    session[:computer_score]=result[3]
  else
    game_over_status = result[0]
    if session[:player_score] > session[:computer_score]
      session[:player_games]+=1
    else
      session[:computer_games]+=1
    end
    session[:player_score]=0
    session[:computer_score]=0
  end
    session[:message] = result[1]
   redirect '/form'
end
