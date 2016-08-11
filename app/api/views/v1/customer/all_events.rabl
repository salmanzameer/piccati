object false

child @events, object_root: false do
  attributes :id, :name, :location, :bridal, :groom, :created_at, :updated_at, :client_id
  node(:photographer_name) {|event| event.photographer.firstname+(" ")+event.photographer.lastname } 
	node(:url) { |event| event.images.first.image.url if event.images.present? }
end

node(:enabled) { false }
node(:events_count) {@total_events}
node(:status) { 1 }
node(:message) { "All events are found successfully!" }
