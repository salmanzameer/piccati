object false

child @followings, object_root: false do
  attributes :id, :firstname, :role_type
  node(:profile_image) { |following| following.avatar.url  }
end
node(:following_count) {@following_count}
node(:status) { "1" }
node(:message) { "Followings are found successfully!" }