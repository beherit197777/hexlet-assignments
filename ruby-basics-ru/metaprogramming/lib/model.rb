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
  case type
  when :datetime
    if value.is_a?(DateTime)
      value.strftime("%Y-%m-%d %H:%M:%S") # Преобразуем DateTime в строку
    elsif value.is_a?(String)
      DateTime.parse(value) # Преобразуем строку в DateTime
    else
      raise TypeError, "Expected DateTime or String, got #{value.class}"
    end
  when :string
    value.to_s # Преобразуем значение в строку
  when :integer
    if value.is_a?(Integer)
      value # Возвращаем значение как есть
    else
      raise TypeError, "Expected Integer, got #{value.class}"
    end
  else
    raise TypeError, "Unsupported type: #{type}"
  end
end
end
