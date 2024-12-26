# frozen_string_literal: true

require 'singleton'
require_relative 'controllers/articles_controller'

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
    @routes[path] = if blk
                      blk
                    else
                      -> (env) do
                        controller_name, action_name = find_controller_and_action(path)

                        controller_class = Object.const_get("#{controller_name.capitalize}Controller")
                        controller = controller_class.new(env)
                        controller.send(action_name)
                      end
                    end
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || ->(env) { "no route found for #{path}" }
    handler.call(env) # pass the env hash to route handler
  end

  def find_controller_and_action(path)
    # result = path.match /\/(\w+)\/(\w+)\/?/  # path = '/articles/index'
    result = path.match(%r{/(?<controller>[^/]+)/(?<action>[^/]+)})
    result.named_captures.transform_keys(&:to_sym)

    [result['controller'], result['action']]
  end
end
