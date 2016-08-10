object false

child @album, object_root: false do
	attributes :id, :name, :description
	child @images, object_root: false do
    node(:image_id) {|img| img.id}
		node(:url) {|img| img.medium_image_url}
	end
end
node(:images_count)	{@total_images}
node(:status) { 1 }
node(:message) { "Album found successfully!" }
