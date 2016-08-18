object false

child @followers, object_root: false do
  attributes :id, :title, :firstname, :lastname
  node(:profile_image) { |follower| follower.avatar.url  }
  node(:is_followed) { "not defined yet"  }
  node(:role_type) { |follower| follower.try(:role_type) || "Client"  }
end
node(:followers_count) {@follower_count}
node(:status) { "1" }
node(:message) { "Followers are found successfully!" }