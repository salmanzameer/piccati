object false

child @photographers, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website, :role_type
  node(:featured_image_url) { |photographer| photographer.feature_image.url }
  node(:is_followed) { |photographer| @requester.following?(photographer) }
  node(:profile_image_url) { |photographer| photographer.avatar.url } 
end
node(:photographers_count) {@photographers.count}
node(:status) { 1 }
node(:message) { "Photographers are found successfully!" }
