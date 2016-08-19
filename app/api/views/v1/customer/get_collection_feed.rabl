object false

child @images, object_root: false do
  attributes :id, :likes_count
  node(:url) { |img| img.image_url  }
  if @requester.class.name == "Client"
    node(:is_liked) { |img| img.likes.where(client_id: @requester.id, like: true).present? }
  else
    node(:is_liked) { nil }
  end
  node(:photographer_id) { |img| img.imageable.photographer.id  }
  node(:photographer_name) { |img| img.imageable.photographer.fullname  }
  node(:photographer_profile_image) { |img| img.imageable.photographer.avatar.url  }
end
node(:images_count) {@images.count}
node(:status) { 1 }
node(:message) { "Collection images found successfully!" }