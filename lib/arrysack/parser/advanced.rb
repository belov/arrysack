# frozen_string_literal: true

require_relative 'name_variants'
require_relative '../nodes/condition'
require_relative '../nodes/group'
module Arrysack
  module Parser
    class Advanced
      attr_reader :params, :schema, :root_group

      def initialize(params, schema, group)
        @params = params.dup
        @schema = schema || Schema.new
        @root_group = group
      end

      def parse
        parse_from_hash(params, root_group)
        root_group.sanitize!
      end

      private

      def parse_from_hash(params, parent_group)
        (params[G_KEY] || {}).keys.sort.each do |key|
          group_params = params[G_KEY][key]
          combinator_name = group_params[M_KEY]
          group = Nodes::Group.new(combinator: combinator_name)

          (group_params[C_KEY] || {}).keys.sort.each do |condition_key|
            condition_params = group_params[C_KEY][condition_key]
            parse_conditions(condition_params, group)
          end

          parse_from_hash(group_params, group)

          parent_group << group
        end
      end

      def parse_conditions(params, parent_group)
        predicate = params[P_KEY]
        attr_params = (params[A_KEY] || {})
        value_params = (params[V_KEY] || {})
        keys = attr_params.keys.sort
        keys.map do |key|
          query_attr = (attr_params[key] || {})['name']
          query_value = (value_params[key] || {})['value']
          methods_chain = parse_methods_chain(query_attr)
          query_value = schema.cast(methods_chain, query_value)
          parent_group << Nodes::Condition.new(predicate, methods_chain, query_value)
        end
      end

      def parse_methods_chain(attr_name)
        methods_chain_variants = NameVariants.all(attr_name.split('_'))
        methods_chain = methods_chain_variants.detect { |variant| schema.type_of(variant) } || []
        attr_name == methods_chain.join('_') ? methods_chain : []
      end
    end
  end
end
