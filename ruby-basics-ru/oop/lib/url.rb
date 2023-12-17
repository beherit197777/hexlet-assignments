# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  include Comparable
  extend Forwardable

  def_delegators :@uri, :scheme, :host, :port

  def initialize(url_string)
    @uri = URI.parse(url_string)
  end

  def query_params
    @uri.query ? URI.decode_www_form(@uri.query).to_h.transform_keys!(&:to_sym) : {}
  end

  def query_param(key, default_value = nil)
    params = query_params
    params.key?(key) ? params[key] : default_value
  end

  def <=>(other)
    self.to_normalized_s <=> other.to_normalized_s
  end

  def to_normalized_s
    [@uri.scheme, @uri.host, @uri.port, normalized_query_params].join
  end

  private

  def normalized_query_params
    params = query_params
    sorted_params = params.sort.to_h
    sorted_params.map { |k, v| "#{k}=#{v}" }.join('&')
  end
end
# END
