require_relative './config/routes'

class App
  def call(env)
    response = router.build_response(env)

    # Rack::Response.new(response).finish
    [200, { 'content-type' => 'text/html' }, [response]]
  end

  private

  def router
    Router.instance
  end
end
