# frozen_string_literal: true

require_relative 'name_variants'
module Arrysack
  module Parser
    class Simple
      attr_reader :params, :schema, :root_group

      def initialize(params, schema, group)
        @params = params.dup
        @schema = schema || Schema.new
        @root_group = group
      end

      def parse
        params.each do |query_attr, query_value|
          reminder = query_attr.dup
          predicate = Predicates.all.detect { |pc| reminder.end_with?(pc.suffix) }
          next unless predicate

          reminder.delete_suffix!(predicate.suffix)
          group_params = split_attribute_name(reminder)
          group = Nodes::Group.new(combinator: group_params[:combinator])
          group_params[:attr_names].each do |attr_name|
            group << build_condition(predicate, attr_name, query_value)
          end
          root_group << group
        end

        root_group.sanitize!
      end

      private

      def build_predicate(query_attr)
        Predicates.all.detect { |pc| query_attr.end_with?(pc.suffix) }
      end

      def split_attribute_name(name)
        list = name.split(Nodes::OrCombinator.splitter)
        combinator = list.size == 1 ? nil : Nodes::OrCombinator
        { combinator: combinator, attr_names: list }
      end

      def build_condition(predicate, attr_name, query_value)
        methods_chain = parse_methods_chain(attr_name)
        return if methods_chain.empty?

        type = schema.type_of(methods_chain)
        return if predicate.disallow?(type)

        value = schema.cast(methods_chain, query_value)
        Nodes::Condition.new(predicate, methods_chain, value)
      end

      def parse_methods_chain(attr_name)
        methods_chain_variants = NameVariants.all(attr_name.split('_'))
        methods_chain = methods_chain_variants.detect { |variant| schema.type_of(variant) } || []
        attr_name == methods_chain.join('_') ? methods_chain : []
      end
    end
  end
end
