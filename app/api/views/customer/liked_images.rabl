object false

child @images, object_root: false do
  attributes :id, :is_liked, :event_id, :client_id
  node(:url) { |img| img.image_url  }
end

node(:status) { 1 }
node(:message) { "All images that are liked found successfully!" }
