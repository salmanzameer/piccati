object false

child @image, object_root: false do
  attributes :is_liked
end

node(:status) { 1 }
node(:message) { "Image is liked/unliked successfully!" }
