# frozen_string_literal: true

require_relative 'collection'
module Arrysack
  module Sorting
    class Parser
      attr_reader :params, :schema

      def initialize(params, schema)
        @params = params['s'] || params[:s]
        @schema = schema
      end

      def parse
        sorting = Collection.new

        simple_parse { |attr_name, order| sorting.add_operator(attr_name, order) } if params.is_a?(String)

        simple_array_parse { |attr_name, order| sorting.add_operator(attr_name, order) } if params.is_a?(Array)

        advanced_parse { |attr_name, order| sorting.add_operator(attr_name, order) } if params.is_a?(Hash)

        sorting
      end

      private

      def advanced_parse
        list = params.keys.sort.map do |index|
          [params[index]['name'], params[index]['dir']]
        end
        list.each do |e|
          yield e[0], e[1] || default_dir
        end
      end

      def simple_parse
        [params.to_s.split('+')].each do |e|
          yield e[0], e[1] || default_dir
        end
      end

      def simple_array_parse
        params.each do |str|
          e = str.to_s.split('+')
          yield e[0], e[1] || default_dir
        end
      end

      def default_dir
        'asc'
      end
    end
  end
end
