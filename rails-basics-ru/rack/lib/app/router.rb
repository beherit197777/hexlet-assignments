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
        [200, {'Content-Type' => 'text/plain'}, ['Hello from the root!']]
      end

      def handle_about
        [200, {'Content-Type' => 'text/plain'}, ['About us page']]
      end

      def handle_not_found
        [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
      end
    # END
end
