object false

child @user , object_root: false do
  attributes :id, :title, :firstname, :lastname, :created_at
  node(:profile_image) { |user| user.avatar.url  }
  node(:image) { |user| user.albums.first.images.first.image.url if user.albums }
end
node(:follows_count) {@user.count}
node(:status) { 1 }
node(:message) { "followers found successfully!" }