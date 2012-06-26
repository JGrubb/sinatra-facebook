class AddDefaultsToCreatedOnUpdatedOn < ActiveRecord::Migration
  def up
    remove_column :bands, :created_on
    remove_column :bands, :updated_on
    change_table :bands do |t|
      t.timestamps
    end
  end

  def down
    remove column :bands, :created_at
    remove column :bands, :updated_at
    add_column :bands, :created_on
    add_column :bands, :updated_on
  end
end
