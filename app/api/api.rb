Rabl.register!

Rabl.configure do |config|
  config.include_json_root = false
end

class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json
  formatter :json, Grape::Formatter::Rabl
  mount Customer::Authenticate
  mount Customer::Information
end