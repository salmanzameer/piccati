object false

child @followings, object_root: false do
  attributes :id, :firstname, :role_type
end
node(:following_count) {@following_count}
node(:status) { "1" }
node(:message) { "Followings are found successfully!" }