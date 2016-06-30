object false

child @events, object_root: false do
  attributes :id, :name, :location, :bridal, :groom, :created_at, :updated_at, :client_id
  node(:photographer_name) {|events| events.client.photographer.firstname + (" ") +events.client.photographer.lastname } 
	node(:url) { |events| events.images.first.image.url if events.images.present? }
end

node(:status) { 1 }
node(:message) { "All events are found successfully!" }
