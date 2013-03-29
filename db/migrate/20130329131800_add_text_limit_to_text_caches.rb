class AddTextLimitToTextCaches < ActiveRecord::Migration
  def up
    change_column :text_caches, :data,               :text, limit: 4294967295
    change_column :text_caches, :hierarchichal_data, :text, limit: 4294967295
  end
  def down
    change_column :text_caches, :data,               :text
    change_column :text_caches, :hierarchichal_data, :text
  end
end
