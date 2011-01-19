class CacheJobsTagList < ActiveRecord::Migration
  def self.up
    add_column :jobs, :cached_tag_list, :string
  end

  def self.down
    remove_column :jobs, :cached_tag_list
  end
end
