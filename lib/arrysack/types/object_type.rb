# frozen_string_literal: true

module Arrysack
  module Types
    class ObjectType < Base
      self.type = :object
      self.rank = 10
      class << self
        def match_sample?(sample)
          sample.respond_to?(:to_h) || sample.respond_to?(:as_json)
        end
      end

      register

      attr_accessor :properties

      def initialize(**options)
        super
        @properties = options[:properties] || {}
      end

      def type_of(method_name)
        properties[method_name]
      end

      def load(schema)
        return unless schema

        (schema[:properties] || {}).each do |attr_name, attr_schema|
          type_object = Arrysack::Types.build(attr_schema)
          next unless type_object

          properties[attr_name.to_s] = type_object.load(attr_schema)
        end
        self
      end

      def load_from(sample)
        return unless sample

        sample.each do |key, value|
          type_object = Arrysack::Types.build_from(value)
          next unless type_object

          properties[key.to_s] = type_object.load_from(value)
        end
        self
      end

      def dump
        props = {}
        properties.each do |k, v|
          props[k.to_sym] = v.dump
        end
        { type: type, properties: props }
      end
    end
  end
end
