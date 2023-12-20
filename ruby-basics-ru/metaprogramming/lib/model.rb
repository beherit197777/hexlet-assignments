# frozen_string_literal: true

# BEGIN
require 'virtus'

module Model
  include Virtus.model

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(name, options = {})
      attribute_name = name.to_sym
      attribute(attribute_name, options[:type] || Virtus::Attribute::Object)
      define_method(name) { send(attribute_name) }
      define_method("#{name}=") { |value| send("#{attribute_name}=", value) }
    end
  end

  def initialize(attributes = {})
    super(attributes)
  end

  def attributes
    attribute_hash = self.class.attribute_set.each_with_object({}) do |attribute, result|
      name = attribute.name.to_s
      result[name] = send(name) unless send(name).nil?
    end

    apply_virtus_coercions(attribute_hash)
  end

  private

  def apply_virtus_coercions(attributes)
    self.class.attribute_set.each_with_object({}) do |attribute, result|
      name = attribute.name.to_s
      value = attributes[name]
      coerced_value = attribute.coerce(value) unless value.nil?
      result[name] = coerced_value
    end
  end
end
# END
