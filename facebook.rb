require 'rubygems'
require 'net/http'
require 'json'
require 'sinatra'
require 'redcarpet'
require 'active_record'

load 'models.rb'

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

get '/:band' do
  fb  = Net::HTTP.get_response("graph.facebook.com", "/#{params[:band]}")
  t   = Net::HTTP.get_response("api.twitter.com", "/1/statuses/user_timeline.json?screen_name=#{params[:band]}&count=3")
  @parsed = JSON.parse(fb.body)
  @tweets = JSON.parse(t.body)
  puts @tweets
  erb :band
end