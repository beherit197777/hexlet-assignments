# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    path = env['PATH_INFO']

    if path.start_with?('/admin')
      [403, {'Content-Type' => 'text/plain'}, []]
    else
      @app.call(env)
    end
    # END
  end
end
