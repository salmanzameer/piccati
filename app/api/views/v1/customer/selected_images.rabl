object false

child @images , object_root: false do
  attributes :id, :imageable_type, :imageable_id
  
  node(:is_selected) { |img| img.is_liked  }
  node(:url) { |img| img.image_url  }
end
node(:images_count) {@images.count}
node(:status) { 1 }
node(:message) { "Selected images found successfully!" }