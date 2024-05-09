# frozen_string_literal: true

require_relative 'types/base'
module Arrysack
  module Types
    class << self
      def build(schema)
        return unless schema.is_a?(Hash)

        type_name = schema[:type]
        format_name = schema[:format]
        type_class = Types[format_name] || Types[type_name]
        return unless type_class

        type_class.new
      end

      def build_from(sample)
        type_class = all.detect { |klass| klass.match_to?(sample) }
        return unless type_class

        type_class.new
      end

      def [](key)
        @index[key.to_s]
      end

      attr_reader :all, :index

      private

      def add(type)
        @all ||= []
        @index ||= {}
        @all << type
        @all.sort_by!(&:rank).reverse!
        @index[type.type.to_s] = type
      end
    end
  end
end
