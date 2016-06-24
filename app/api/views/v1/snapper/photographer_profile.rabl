object false

child @photographer, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website
  node(:url) { |img| img.avatar.url }
end

child @image, object_root: false do
	node(:url) { |img| img.image.url }
end
node(:status) { 1 }
node(:message) { "Photographer profile found successfully!" }
