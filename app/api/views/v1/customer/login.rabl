object false

child @client, object_root: false do
  attributes :id, :firstname, :authentication_token, :username
end

node(:status) { "1" }
node(:message) { "Client logged-in successfully!" }