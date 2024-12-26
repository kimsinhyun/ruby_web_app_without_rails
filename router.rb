# frozen_string_literal: true

require 'singleton'

class Router
  include Singleton

  attr_reader :routes

  class << self
    def draw(&blk)
      Router.instance.instance_exec(&blk)
    end
  end

  def initialize
    @routes = {}
  end

  def get(path, &blk)
    @routes[path] = blk
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    p "path: #{path}"
    # handler = @routes[path] || proc { |env| "no route found for #{path}" }
    handler = @routes[path] || ->(env) { "no route found for #{path}" }
    handler.call(env) # pass the env hash to route handler
  end
end
