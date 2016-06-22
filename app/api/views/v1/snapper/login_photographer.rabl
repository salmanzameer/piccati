object false

child @photographer, object_root: false do
	  attributes :id, :firstname, :email, :contnumber, :website, :authentication_token, :username, :lastname, :title
	  node(:url) { |user| user.avatar.url  }
	end

	node(:status) { "1" }
	node(:message) { "Photographer logded in successfully!" }