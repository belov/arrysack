# frozen_string_literal: true

module Arrysack
  module Types
    class ArrayType < Base
      self.type = :array
      self.rank = 1000
      class << self
        def match_sample?(sample)
          sample.is_a?(::Array)
        end
      end

      attr_accessor :items

      register

      def initialize(**options)
        super
        @items = options[:items] || {}
      end

      def type_of(method_name)
        return if items.nil?

        items.type_of(method_name)
      end

      def load(schema)
        items_schema = schema[:items]
        type_object = Arrysack::Types.build(items_schema)
        return unless type_object

        self.items = type_object.load(items_schema)

        self
      end

      def load_from(sample)
        item = sample.detect { |i| !i.nil? }
        type_object = Arrysack::Types.build_from(item)
        return unless type_object

        self.items = type_object.load_from(item)

        self
      end

      def dump
        { type: type, items: items.dump }
      end
    end
  end
end
