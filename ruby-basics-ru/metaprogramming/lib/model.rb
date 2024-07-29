# frozen_string_literal: true
require 'date'

module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(name, options = {})
      @attributes ||= {}
      @attributes[name] = options

      define_method(name) do
        value = instance_variable_get("@#{name}")
        if value.nil?
          nil
        else
          convert_type(value, options[:type])
        end
      end

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
    end

    def attributes
      @attributes
    end
  end

  def initialize(attrs = {})
    self.class.attributes.each do |name, _options|
      send("#{name}=", attrs[name]) if attrs.key?(name)
    end
  end

  def attributes
    self.class.attributes.each_with_object({}) do |(name, options), result|
      value = send(name)
      result[name] = value.nil? ? nil : convert_type(value, options[:type])
    end
  end

  private

  def convert_type(value, type)
    return value unless type

    case type
    when :integer then value.to_i
    when :float then value.to_f
    when :string then value.to_s
    when :datetime then DateTime.parse(value)
    else value
    end
  end
end



