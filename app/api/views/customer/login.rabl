object false

child @client, object_root: false do
  attributes :id, :first_name, :authentication_token, :user_name
end

node(:status) { "1" }
node(:message) { "Client logged-in successfully!" }