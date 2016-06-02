Rabl.register!

Rabl.configure do |config|
  config.include_json_root = false
end

class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::Rabl
  mount Base
end