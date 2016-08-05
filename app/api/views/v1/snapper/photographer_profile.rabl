object false

child @user, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website, :description, :rating, :badge
  node(:url) { |img| img.avatar.url }
  if @user.class.name == "Photographer"
	  child :albums, object_root: false do
			attributes :id, :name, :description
			child :images, object_root: false do
        node(:image_id) { |img| img.id }
				node(:url) { |img| img.image.url }
			end
		end
    node(:number_of_clients) { |photographer| photographer.clients.count }
    node(:number_of_follows) { |photographer| photographer.followers_count }
    node(:number_of_likes) {  |photographer| photographer.images_likes_count }
	elsif @user.class.name == "Client"
		@user.photographer_id.present? ? node(:enabled) { true } : node(:enabled) { false }
	end
end

node(:status) { 1 }
node(:message) { "Profile found successfully!" }
