# frozen_string_literal: true

module Arrysack
  class ItemValue
    using Arrysack::CoreExt

    attr_reader :item, :methods_chain

    def initialize(item, methods_chain)
      @item = item
      @methods_chain = Array.wrap(methods_chain)
    end

    def extract
      value = item
      methods_chain.each do |method_name|
        value = object_value(value, method_name)
      end
      value
    end

    private

    def object_value(object, method_name)
      return object.map { |i| object_value(i, method_name) } if object.is_a?(Array)
      return object[method_name.to_s] || object[method_name.to_sym] if object.is_a?(Hash)
      return object.public_send(method_name) if object.respond_to?(method_name)

      object
    end
  end
end
