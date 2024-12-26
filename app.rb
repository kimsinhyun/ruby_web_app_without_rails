require 'logger'
require 'zeitwerk'
require_relative './config/routes'

class App
  def initialize
    @logger = Logger.new('log/development.log')

    loader = Zeitwerk::Loader.new
    loader.push_dir('controllers')
    loader.push_dir('models')
    loader.setup
  end

  def call(env)
    @logger.info "#{env['REQUEST_METHOD']}: #{env['REQUEST_PATH']}"
    response_html = router.build_response(env)
    @headers = { 'content-type' => 'text/html' }

    # Rack::Response.new(response).finish
    [200, @headers, [response_html]]

  rescue => e
    @logger.add(Logger::ERROR, e)
    [200, @headers, ["Error: #{e.message}"]]
  end

  private

  def router
    Router.instance
  end
end
