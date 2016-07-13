object false

child @images, object_root: false do
  attributes :id, :event_id, :is_liked
  node(:url) { |img| img.image_url  }
end
node(:images_count) {@total_images}
node(:status) { "1" }
node(:message) { "Images are found successfully!" }