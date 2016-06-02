class Base < Grape::API
	prefix 'api'
	version 'v1', using: :path
  mount Customer::Authenticate
  mount Customer::Information
end
