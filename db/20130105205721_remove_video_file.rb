class RemoveVideoFile < ActiveRecord::Migration
  def up
      remove_attachment :videos, :file
      add_attachment :videos, :video
  end

  def down
  end
end
