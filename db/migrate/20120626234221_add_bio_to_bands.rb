class AddBioToBands < ActiveRecord::Migration
  def up
    add_column :bands, :bio, :text
  end

  def down
    remove_column :bands, :bio, :text
  end
end
