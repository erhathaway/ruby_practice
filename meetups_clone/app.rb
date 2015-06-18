require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  groups = MeetupGroup.all
  erb :index, locals: {groups: groups}
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end

get "/group/:id" do
  group = MeetupGroup.find(params[:id])

  #get events
  events = MeetupEvent.where(meetup_group_id: group.id)

  #get users
  users_id = GroupUser.where(group_id: group.id)
  users = []
  users_id.each do |i|
    users << User.find(i.id)
  end
  erb :group, locals: { group: group, users: users, events: events }

end

get "/user/:id" do
  user = User.find(params[:id])
  erb :user, locals: { user: user }
end
