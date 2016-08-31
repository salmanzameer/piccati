object false

child @activities , object_root: false do
  attributes :id
  child :owner , object_root: false do
    attributes :id, :title, :firstname, :lastname, :created_at
    node(:profile_image) { |owner| owner.avatar.url  }
  end
  child :trackable, if: lambda { |activity| activity.trackable_type == "Image" }  do
    node(:image_id) { |trackable| trackable.id }
    node(:image_url) { |trackable| trackable.image.url }
  end

  child :trackable, if: lambda { |activity| activity.trackable_type == "Album" }  do
    node(:album_id) { |trackable| trackable.id }
    node(:album_name) { |trackable| trackable.name }
    node(:featured_image_url) { |trackable| trackable.images.first.image.url if trackable.images.present? }
    node(:images_count) { |trackable| trackable.images.count }
  end

  child :trackable, if: lambda { |activity| activity.trackable_type == "Enquiry" }  do
    node(:event_date) { |trackable| trackable.event_date }
    node(:total_guests) { |trackable| trackable.guests }
  end

  child :trackable, if: lambda { |activity| activity.trackable_type == "Photographer" }  do
  end

  node(:activity) { |activity| activity.key }
end

node(:status) { 1 }
node(:message) { "Feed found successfully!" }