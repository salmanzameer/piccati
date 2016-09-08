module AlbumsHelper

	def album_check_status (album)
		return @album.images.where(status: "1")
	end
end
