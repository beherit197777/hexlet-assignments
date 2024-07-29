# frozen_string_literal: true

require_relative 'model'
require 'date'

class Post
  attr_reader :id, :title, :body, :created_at, :published

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @body = attributes[:body]
    @created_at = DateTime.parse(attributes[:created_at])
    self.published = attributes[:published]
  end

  def published=(value)
    if [true, false].include?(value)
      @published = value
    else
      raise ArgumentError, "published must be a boolean"
    end
  end

  def attributes
    {
      id: @id,
      title: @title,
      body: @body,
      created_at: @created_at.strftime("%Y-%m-%d %H:%M:%S"),
      published: @published
    }
  end
end
