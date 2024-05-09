# frozen_string_literal: true

require_relative 'types'
module Arrysack
  class Schema
    using Arrysack::CoreExt

    attr_reader :main

    def valid?
      !main.nil?
    end

    def invalid?
      !valid?
    end

    def cast(methods_chain, value)
      return value if invalid?

      type = type_of(methods_chain)
      return value if type.nil?

      type.cast(value)
    end

    def type_of(methods_chain)
      return if invalid?

      methods = Array.wrap(methods_chain).compact
      methods.reduce(main) do |type, method_name|
        next type if type.nil?

        type.type_of(method_name)
      end
    end

    def load(schema_hash)
      return self unless schema_hash.is_a?(Hash)

      type = Arrysack::Types.build(schema_hash)
      return self unless type

      @main = type.load(schema_hash)

      self
    end

    def load_from(sample)
      type = Arrysack::Types.build_from(sample)
      return self unless type

      @main = type.load_from(sample)
      self
    end

    def dump
      main.dump
    end

    class << self
      def load(schema_hash)
        new.load(schema_hash)
      end

      def load_from(sample)
        new.load_from(sample)
      end
    end
  end
end
