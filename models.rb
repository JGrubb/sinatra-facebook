class Band < ActiveRecord::Base
  validates :name, :twitter_user, :fb_user, :presence => true
  validates :name, :twitter_user, :fb_user, :uniqueness => true
end