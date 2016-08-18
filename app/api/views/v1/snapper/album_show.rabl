object false

child @album, object_root: false do
	attributes :id, :name, :description
	child @images, object_root: false do
    node(:image_id) {|img| img.id}
		node(:url) {|img| img.image_url}
    node(:is_liked) {|img| @requester.likes.where(image_id: img.id, like: true).present? if @requester.try(:likes).present? }
	end
end
node(:images_count)	{@total_images}
node(:status) { 1 }
node(:message) { "Album found successfully!" }
