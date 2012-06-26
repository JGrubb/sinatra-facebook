#ActiveRecord::Base.establish_connection(
#  :adapter  => "mysql",
#  :database => "sinatra_test",
#  :username => "root",
#  :password => "root",
#  :host     => "localhost"
#)

require 'activerecord'
require 'uri'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)