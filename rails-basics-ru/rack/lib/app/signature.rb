# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)

    # Преобразуем тело ответа в строку
    body = response.respond_to?(:each) ? response.join : response.to_s

    # Создаем хеш с использованием SHA-256
    sha256_hash = Digest::SHA256.hexdigest(body)

    # Добавляем хеш к телу ответа
    new_response = [body + "\n" + sha256_hash]

    [status, headers, new_response]
  end
    # END
end
