class AddAttachmentAvatarToHorses < ActiveRecord::Migration
  def self.up
    change_table :horses do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :horses, :avatar
  end
end
