object false

child @image, object_root: false do
  node(:is_selected) { |img| img.is_liked }
end

node(:status) { 1 }
node(:message) { "Image is liked/unliked successfully!" }
