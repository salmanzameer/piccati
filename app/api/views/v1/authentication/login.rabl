object false

child @user => :user do
	  attributes :id, :firstname, :email, :contnumber, :website, :authentication_token, :username, :lastname, :title
    node(:url) { @user.avatar.url }
    if @user.class.name == "Client"
      node(:role_type) { "Client"  }
      node(:invited_by_id) { |user| user.invited_by_id }
      node(:invited_by_type) { |user| user.invited_by_type }
    else
      node(:role_type) { |user| user.role_type  }
    end
end
node(:enabled) { false }
node(:status) { "1" }
node(:message) { "Logged in successfully!" }