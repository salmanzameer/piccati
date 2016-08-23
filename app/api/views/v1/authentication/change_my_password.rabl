node(:status) { "1" }
child :errors, object_root: false do
  @user.errors.messages.map{ |key,value|
    node(key) { value.first }
  }
end
node(:email) { @user.email }
node(:message) { "Successfull" }