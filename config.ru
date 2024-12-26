# frozen_string_literal: true

require 'rack'
require_relative 'app'

app = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Reloader, 0
  use Rack::CommonLogger
  use Rack::Static, urls: ['/public']
  # use Rack::Lint

  run App.new
end.to_app
# end
run app
