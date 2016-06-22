object false

child @photographer, object_root: false do
  attributes :id, :title, :firstname, :lastname, :contnumber, :email, :website
  node(:url) { |img| img.avatar.url }
  child @events, object_root: false do
		attributes :id, :name, :location, :groom, :public
		node(:bride){ |event| event.bridal }
		child :images do
		node(:url) {|img| img.image_url}
		end
	end

end

node(:status) { 1 }
node(:message) { "Photographer profile found successfully!" }
