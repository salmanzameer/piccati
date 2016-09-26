object false

child @user => :user do
  attributes :id, :firstname, :email, :contnumber, :authentication_token, :city, :description
  node(:url) { |user| user.avatar.url  }
  if @user.class.name == "Client"
    node(:role_type) { "Client"  }
    node(:lastname) { |user| user.lastname }
  else
    node(:role_type) { |user| user.role_type }
    node(:website) { |user| user.website  }
  end
end

node(:status) { "1" }
node(:message) { "User updated successfully!" }