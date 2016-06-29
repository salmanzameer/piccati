object false

child @user, object_root: false do
	  attributes :id, :firstname, :email, :contnumber, :website, :authentication_token, :username, :lastname, :title
	  node(:url) { |user| user.avatar.url  }
	if @user.class.name == "Client"
		@user.photographer_id.present? ? node(:enabled) { true } : node(:enabled) { false }
	end
end

node(:status) { "1" }
node(:message) { "Logged in successfully!" }