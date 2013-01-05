class AddAttachmentToVideo < ActiveRecord::Migration
  def change
      add_attachment :videos, :video
      add_column :videos, :video_remote_url, :string
  end
end
