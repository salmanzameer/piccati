object false

child @user, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website
  node(:url) { |img| img.avatar.url }
  if @user.class.name == "Photographer"
	  child :albums, object_root: false do
			attributes :id, :name, :description
			child :images, object_root: false do
				node(:url) { |img| img.image.url }
			end
		end
	end
end

node(:status) { 1 }
node(:message) { "Profile found successfully!" }
