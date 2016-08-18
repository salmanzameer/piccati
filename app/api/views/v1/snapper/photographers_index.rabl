object false

child @photographer, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website, :role_type
  node(:featured_image_url) { |photographer| photographer.feature_image.url }
  node(:is_followed) { |photographer| photographer.followers.present? }
	node(:profile_image_url) { |photographer| photographer.avatar.url }	
end
node(:photographers_count) {@total_photographers}
node(:status) { 1 }
node(:message) { "Photographer profiles are found successfully!" }
