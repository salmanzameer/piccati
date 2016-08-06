object false

child @photographer, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website, :role_type
  node(:url) { |img| img.avatar.url }
	node(:album_url) { |photographer| photographer.albums.first.images.sample.image_url if photographer.albums.present? && photographer.albums.first.images.present? }	
end
node(:photographers_count) {@total_photographers}
node(:status) { 1 }
node(:message) { "Photographer profiles are found successfully!" }
