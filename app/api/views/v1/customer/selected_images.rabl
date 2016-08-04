object false

child @images , object_root: false do
  attributes :id, :is_liked, :event_id
  node(:url) { |img| img.image_url  }
end
node(:images_count) {@images.count}
node(:status) { 1 }
node(:message) { "Selected images found successfully!" }