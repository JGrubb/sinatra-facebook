class CreateBands < ActiveRecord::Migration
  def up
    create_table  :bands do |t|
      t.string    :name
      t.string    :twitter_user
      t.string    :fb_user
      t.datetime  :created_on
      t.datetime  :updated_on
    end
  end

  def down
    drop_table :bands
  end
end
