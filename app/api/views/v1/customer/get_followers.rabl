object false

child @followers, object_root: false do
  attributes :id, :title, :firstname, :lastname
  node(:profile_image) { |follower| follower.avatar.url  }
  node(:is_followed) { "not defined yet"  }
end
node(:followers_count) {@follower_count}
node(:status) { "1" }
node(:message) { "Followers are found successfully!" }