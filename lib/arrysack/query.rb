# frozen_string_literal: true

require 'ostruct'
require_relative 'nodes/group'
require_relative 'parser'
require_relative 'sorting/parser'
module Arrysack
  class Query
    attr_reader :array, :schema, :params

    def initialize(params = {}, schema = nil)
      @params = OpenStruct.new(params)
      @schema = schema.is_a?(Hash) && !schema.empty? ? schema : nil
      @array = []
    end

    def on(array)
      @array = array if array.is_a?(Array)
      self
    end

    def result
      return [] unless array
      return [] if array.empty?

      select_schema
      sorting.sort(list)
    end

    def list
      @list ||= group.valid? ? array.select { |item| group.result(item) } : array
    end

    def sorting
      @sorting ||= Sorting::Parser.new(params.to_h, schema).parse
    end

    def group
      @group ||= Arrysack::Parser.parse(params.to_h, schema)
    end

    private

    def sample
      array.detect { |i| !i.nil? }
    end

    def select_schema
      @schema = Schema.load(@schema)
      return if @schema.valid?

      @schema = Schema.load_from(sample)
    end

    def respond_to_missing?(name, include_private = false)
      params.respond_to?(name, include_private)
    end

    def method_missing(method, *args, &block)
      params.send(method, *args, &block)
    end
  end
end
