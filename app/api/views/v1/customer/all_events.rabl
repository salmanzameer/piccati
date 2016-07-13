object false

child @events, object_root: false do
  attributes :id, :name, :location, :bridal, :groom, :created_at, :updated_at, :client_id
  node(:photographer_name) {|events| events.client.photographer.firstname + (" ") +events.client.photographer.lastname } 
	node(:url) { |events| events.images.first.image.url if events.images.present? }
end

@client.photographer_id.present? ? node(:enabled) { true } : node(:enabled) { false }
node(:events_count) {@total_events}
node(:status) { 1 }
node(:message) { "All events are found successfully!" }
