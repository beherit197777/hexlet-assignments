# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/post'

require 'minitest/autorun'
require_relative '../lib/post'

class PostTest < Minitest::Test
  def setup
    @attributes = {
      id: 1,
      title: 'Hello World',
      body: 'First post!',
      created_at: '2021-03-01 00:00:00', 
      published: true
    }

    @expected_attributes = {
      id: @attributes[:id],
      title: @attributes[:title],
      body: @attributes[:body],
      created_at: @attributes[:created_at],
      published: @attributes[:published]
    }
  end

  def test_model_contains_attributes_on_initialize
    post = Post.new(@attributes)

    assert_equal @expected_attributes[:id], post.id
    assert_equal @expected_attributes[:title], post.title
    assert_equal @expected_attributes[:body], post.body
    assert_equal DateTime.parse(@expected_attributes[:created_at]), post.created_at 
    assert_equal @expected_attributes[:published], post.published
    assert_equal @expected_attributes, post.attributes
  end

  def test_model_contains_attributes_with_accessors
    post = Post.new(id: nil, title: nil, body: nil, created_at: Time.now.to_s, published: false)

    post.instance_variable_set(:@id, @attributes[:id])
    post.instance_variable_set(:@title, @attributes[:title])
    post.instance_variable_set(:@body, @attributes[:body])
    post.instance_variable_set(:@created_at, DateTime.parse(@attributes[:created_at]))
    post.published = @attributes[:published]

    assert_equal @expected_attributes[:id], post.id
    assert_equal @expected_attributes[:title], post.title
    assert_equal @expected_attributes[:body], post.body
    assert_equal DateTime.parse(@expected_attributes[:created_at]), post.created_at 
    assert_equal @expected_attributes[:published], post.published
    assert_equal @expected_attributes, post.attributes
  end

  def test_each_model_has_its_own_attributes
    post1 = Post.new(title: 'test1', body: '', created_at: Time.now.to_s, published: false)
    post2 = Post.new(title: 'test2', body: '', created_at: Time.now.to_s, published: false)

    assert_equal 'test1', post1.title
    assert_equal 'test2', post2.title
    refute_equal post1.title, post2.title
  end
end
