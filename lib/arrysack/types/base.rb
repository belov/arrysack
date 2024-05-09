# frozen_string_literal: true

module Arrysack
  module Types
    class Base
      attr_accessor :format, :example

      def initialize(**options)
        @format = options[:format]
        @example = options[:example]
      end

      def type
        self.class.type
      end

      def type_of(_method_name)
        nil
      end

      def default_format
        self.class.format
      end

      def cast(input)
        input
      end

      def load(schema)
        return unless schema

        schema.slice(:format, :example).each do |key, value|
          public_send("#{key}=", value)
        end
        self
      end

      def load_from(sample)
        self.format = default_format
        self.example = sample.to_s
        self
      end

      def dump
        { type: type, format: format, example: example }.compact
      end

      class << self
        attr_accessor :type, :match_proc, :format
        attr_writer :rank

        def match_to?(sample)
          !!match_sample?(sample)
        end

        def rank
          return 100 unless @rank

          @rank
        end

        def register
          Types.send :add, self
        end

        private

        # override
        def match_sample?(_sample)
          false
        end
      end
    end
  end
end
