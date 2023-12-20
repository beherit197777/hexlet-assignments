# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    # BEGIN
    path = env['PATH_INFO']
    case path
    when '/'
      handle_root
    when '/about'
      handle_about
    else
      handle_not_found
    end
  end

  private

  def handle_root
    [200, {'Content-Type' => 'text/plain'}, ['Hello, World!']]
  end

  def handle_about
    [200, {'Content-Type' => 'text/plain'}, ['About page']]
  end

  def handle_not_found
    [404, {'Content-Type' => 'text/plain'}, ['404 Not Found']]
  end
    # END
end
