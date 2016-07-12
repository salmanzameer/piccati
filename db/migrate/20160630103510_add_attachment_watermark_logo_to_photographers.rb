class AddAttachmentWatermarkLogoToPhotographers < ActiveRecord::Migration
  def self.up
    change_table :photographers do |t|
      t.attachment :watermark_logo
    end
  end

  def self.down
    remove_attachment :photographers, :watermark_logo
  end
end
