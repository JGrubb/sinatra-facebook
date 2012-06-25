require 'rubygems'
require 'net/http'
require 'json'
require 'sinatra'
require 'redcarpet'

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
  fb = Net::HTTP.get_response("graph.facebook.com", "/#{params[:band]}")
  @parsed = JSON.parse(fb.body)
  erb :band
end