class AddAttachmentFeatureImageToPhotographers < ActiveRecord::Migration
  def self.up
    change_table :photographers do |t|
      t.attachment :feature_image
    end
  end

  def self.down
    remove_attachment :photographers, :feature_image
  end
end
