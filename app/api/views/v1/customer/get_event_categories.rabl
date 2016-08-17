object false

child @categories , object_root: false do
  attributes :id, :name
end

node(:status) { 1 }
node(:message) { "Event categories found successfully!" }