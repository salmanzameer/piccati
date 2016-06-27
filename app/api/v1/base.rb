class Base < Grape::API
	prefix 'api'
	version 'v1', using: :path
  mount Customer::Information
  mount Snapper::GeneralData
  mount Authentication::Register
  mount Authentication::Authenticate
end
