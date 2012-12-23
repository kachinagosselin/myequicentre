class RemoveAttachmentAvatarFromHorses < ActiveRecord::Migration
  def up
      remove_attachment :horses, :avatar
  end

  def down
      add_attachment :horses, :avatar
  end
end
