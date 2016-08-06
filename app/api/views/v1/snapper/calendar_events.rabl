object false

child @events, object_root: false do
	attributes :id, :name, :location, :groom, :start_time
	node(:bride) {|event| event.bridal}
end

node(:status) { 1 }
node(:message) { "Events found successfully!" }
