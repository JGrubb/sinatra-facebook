require 'rubygems'
require 'net/http'
require 'json'
require 'sinatra'
require 'redcarpet'
require 'active_record'
#require 'sinatra/reloader'
load 'models.rb'
load 'db/config.rb'

#set :logging, :true

def dat_render(text)
  options = {
    :autolink => true,
    :space_after_headers => true,
    :no_intra_emphasis => true,
    :fenced_code_blocks => true
  }
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  markdown.render(text)
end


get '/' do
  erb :index
end

get '/bands/new' do
  @band = Band.new
  erb :new
end

post '/bands/new' do
  @band = Band.new(params[:band])
  if @band.save!
    redirect "/bands/#{@band.id}"
  else
    "still problem"
  end
end

get '/bands' do
  @bands = Band.order("name ASC")
  erb :all
end

get '/bands/:id' do
  @band = Band.find(params[:id])
  fb  = Net::HTTP.get_response("graph.facebook.com", "/#{@band.fb_user}")
  t   = Net::HTTP.get_response("api.twitter.com", "/1/statuses/user_timeline.json?screen_name=#{@band.twitter_user}&count=3")
  @parsed = JSON.parse(fb.body)
  @tweets = JSON.parse(t.body)
  #puts @tweets
  erb :band
end

after do
  ActiveRecord::Base.clear_active_connections!
end