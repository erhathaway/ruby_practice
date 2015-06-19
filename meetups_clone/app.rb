require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/json'
require 'omniauth-github'
require 'pry'

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

  def get_group(group_id)
    MeetupGroup.find(group_id)
  end

  def get_user(user_id)
    User.find(user_id)
  end

  def user_groups
    GroupUser.where(user_id: current_user.id)
  end

  def user_events
    EventUser.where(user_id: current_user.id)
  end

  def user_in_group?(group_id)
    user_groups.each do |group|
      if group.group_id == group_id
        return true 
      end
    end
    false
  end

  def user_in_event?(event_id)
    user_events.each do |event|
      return true if event.id == event_id
    end
    false
  end

  def group_events(group_id)
    MeetupEvent.where(meetup_group_id: group_id)
  end

  def group_users(group_id)
    users_id = GroupUser.where(group_id: group_id)
    users = []
    users_id.each do |i|
      # binding.pry
      users << User.find(i.user_id)
    end
    users
  end

  def event_users(event_id)
    users_id = EventUser.where(group_id: event_id)
    users = []
    users_id.each do |i|
      # binding.pry
      users << User.find(i.user_id)
    end
    users
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
  group = get_group(params[:id])
  events = group_events(group.id)
  users = group_users(group.id)

  erb :group, locals: { group: group}
  # if user_in_group?(group.id)
  #   erb :group, locals: { status: 'joined', group: group, users: users, events: events }
  # else
  #   erb :group, locals: { status: 'visitor', group: group}
  # end
end

get "/user/:id" do
  user = get_user(params[:id])
  erb :user, locals: { user: user }
end

post "/group/join" do
  group_id = params["group_id"].to_i
  if not user_in_group?(group_id)
    GroupUser.create(user_id: current_user.id, group_id: group_id)
    return { group_status: 'joined', group: get_group(group_id), users: group_users(group_id), group_events: group_events(group_id) }.to_json
  else
    return { error: "You shouldn't have done that..."}.to_json
  end
end

post "/group/leave" do
  group_id = params["group_id"].to_i
  # binding.pry
  if user_in_group?(group_id)
    GroupUser.where(user_id: current_user.id, group_id: group_id).destroy_all
    return { group_status: 'visitor', group: get_group(group_id), users: [], group_events: group_events(group_id) }.to_json
  else
    return { error: "You shouldn't have done that..."}.to_json
  end
end



get "/data" do
  group_id = params[:group_id].to_i

  group = get_group(group_id)
  events = group_events(group_id)
  users = group_users(group_id)

  if user_in_group?(group_id)
    return { group_status: 'joined', group: group, users: users, group_events: events }.to_json
  else
    return { group_status: 'visitor', group: group, users: [], group_events: []}.to_json
  end
end

