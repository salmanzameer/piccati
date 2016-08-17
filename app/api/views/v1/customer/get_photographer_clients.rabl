object false

child @clients, object_root: false do
  attributes :id, :title, :firstname, :lastname
  node(:profile_image) { |client| client.avatar.url }
  node(:is_following) { |client| client.following?(@photographer) }
end
node(:clients_count) {@clients.count}
node(:status) { "1" }
node(:message) { "Clients are found successfully!" }