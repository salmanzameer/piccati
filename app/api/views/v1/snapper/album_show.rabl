object false

child @album, object_root: false do
	attributes :id, :name, :description
	child @images, object_root: false do
		node(:url) {|img| img.image_url}
	end
end
node(:images_count)	{@total_images}
node(:status) { 1 }
node(:message) { "Album found successfully!" }
