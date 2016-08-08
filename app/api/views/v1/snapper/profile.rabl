object false

child @user, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website, :description
  node(:is_followed) { |user| @requester.following?(user) }
  node(:url) { |img| img.avatar.url }
  if @user.class.name == "Photographer"
  node(:rating) { |user| user.rating }
  node(:badge) { |user| user.badge }
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
		node(:enabled) { false }
	end
end

node(:status) { 1 }
node(:message) { "Profile found successfully!" }
