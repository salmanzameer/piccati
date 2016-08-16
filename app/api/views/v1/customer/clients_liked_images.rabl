object false

child @images , object_root: false do
  attributes :is_liked, :event_id
  node(:image_id) { |img| img.id  }
  node(:url) { |img| img.image_url  }
end
node(:images_count) {@images.count}
node(:status) { 1 }
node(:message) { "Liked images found successfully!" }