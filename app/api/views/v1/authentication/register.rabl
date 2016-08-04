object false

child @user, object_root: false do
	  attributes :id, :firstname, :email, :contnumber, :website, :authentication_token, :username, :lastname, :title, :city
	  node(:url) { |user| user.avatar.url  }
	end

	node(:status) { "1" }
	node(:message) { "You are registered successfully!" }