object false

child @photographer, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website
  node(:url) { |img| img.avatar.url }
	child :albums, object_root: false do
		attributes :id, :name, :description
		child :images, object_root: false do
			node(:url) { |img| img.image.url }
		end
	end
end

node(:status) { 1 }
node(:message) { "Photographer profile found successfully!" }
