object false

child @user => :user do
	  attributes :id, :firstname, :email, :contnumber, :website, :authentication_token, :username, :lastname, :title, :city
	  node(:url) { |user| user.avatar.url  }
    if @user.class.name == "Client"
      node(:role_type) { "Client"  }
    else
      node(:role_type) { |user| user.role_type  }
    end
	end
	node(:status) { "1" }
	node(:message) { "You are registered successfully!" }