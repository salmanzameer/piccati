class AddAttachmentAvatarToPhotographers < ActiveRecord::Migration
  def self.up
    change_table :photographers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :photographers, :avatar
  end
end
