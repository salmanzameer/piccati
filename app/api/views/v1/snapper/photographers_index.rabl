object false

child @photographer, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website, :role_type
  node(:url) { |img| img.feature_image.url }
  node(:is_followed) { |photographer| photographer.followers.present? }
	node(:album_url) { |photographer| photographer.albums.first.images.sample.medium_image_url if photographer.albums.present? && photographer.albums.first.images.present? }	
end
node(:photographers_count) {@total_photographers}
node(:status) { 1 }
node(:message) { "Photographer profiles are found successfully!" }
