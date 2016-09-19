object false

child @images, object_root: false do
  attributes :id, :event_id
  node(:url) { |img| img.image_url  }
  node(:is_selected) { |img| img.is_liked  }
  node(:is_liked) { |img| img.is_liked?(@client)  }
end
node(:images_count) {@total_images}
node(:status) { "1" }
node(:message) { "Images are found successfully!" }