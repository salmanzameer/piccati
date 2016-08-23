node(:status) { "1" }
node(:errors) { @user.errors.messages }
node(:email) { @user.email }
node(:message) { "Successfull" }