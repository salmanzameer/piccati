object @image
node(:image_id) { |img| img.id }
node(:url)      { |img| img.image.url }
node(:is_liked) { |img| img.likes.is_liked?(@requester)}