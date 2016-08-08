message = "Image has been unliked successfully!"
if @like.like
  message = "Image has been liked successfully!"
end
  node(:status) { "1" }
  node(:is_liked){ @like.like }
  node(:message) { message } 