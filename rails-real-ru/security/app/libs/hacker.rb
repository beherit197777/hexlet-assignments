# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def self.hack(email, password)
      new(email, password).hack
    end
  
    def initialize(email, password)
      @email = email
      @password = password
      @http = Net::HTTP.new(URI(BASE_URL).host, URI(BASE_URL).port)
    end
  
    def hack
      csrf_token, cookies = get_csrf_token_and_cookies
      register_user(csrf_token, cookies)
    end
  
    private
  
    def get_csrf_token_and_cookies
      response = @http.get('/users/sign_up')
      cookies = response['set-cookie']
      
      doc = Nokogiri::HTML(response.body)
      csrf_token = doc.at('meta[name="csrf-token"]')['content']
      
      [csrf_token, cookies]
    end
  
    def register_user(csrf_token, cookies)
      headers = {
        'Cookie' => cookies,
        'X-CSRF-Token' => csrf_token,
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
  
      body = URI.encode_www_form({
        'user[email]' => @email,
        'user[password]' => @password,
        'user[password_confirmation]' => @password
      })
  
      response = @http.post('/users', body, headers)
      
      if response.code == '302' && response['location'].include?('/posts')
        puts "User successfully registered with email: #{@email}"
      else
        puts "Registration failed. Response code: #{response.code}"
      end # BEGIN
  end
end
end