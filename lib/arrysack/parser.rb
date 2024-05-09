# frozen_string_literal: true

# {
#   "authenticity_token": "OEdJasZwUTxPZtkxN1FbjaxxgK2XP1tfTHsImlM385gcgqvtmrrC22CPpPaSWlNd-Tcnmuhdxae8TzOKwsu_yg",
#   "q[g][0][m]": "or",
#   "q[g][0][c][0][a][0][name]": "first_name",
#   "q[g][0][c][0][p]": "gt",
#   "q[g][0][c][0][v][0][value]": "4",
#
#   "q[g][0][c][1][a][0][name]": "id",
#   "q[g][0][c][1][p]": "lt",
#   "q[g][0][c][1][v][0][value]": "54",
#
#   "q[g][0][c][1714074642220][a][0][name]": "posts_title",
#   "q[g][0][c][1714074642220][p]": "start",
#   "q[g][0][c][1714074642220][v][0][value]": "a",
#
#   "q[g][0][g][0][m]": "or",
#   "q[g][0][g][0][c][0][a][0][name]": "email",
#   "q[g][0][g][0][c][0][p]": "cont",
#   "q[g][0][g][0][c][0][v][0][value]": "ojk",
#   "commit": "Search"
# }
# str = 'authenticity_token=OEdJasZwUTxPZtkxN1FbjaxxgK2XP1tfTHsImlM385gcgqvtmrrC22CPpPaSWlNd-Tcnmuhdxae8TzOKwsu_yg&q%5Bg%5D%5B0%5D%5Bm%5D=or&q%5Bg%5D%5B0%5D%5Bc%5D%5B0%5D%5Ba%5D%5B0%5D%5Bname%5D=first_name&q%5Bg%5D%5B0%5D%5Bc%5D%5B0%5D%5Bp%5D=gt&q%5Bg%5D%5B0%5D%5Bc%5D%5B0%5D%5Bv%5D%5B0%5D%5Bvalue%5D=4&q%5Bg%5D%5B0%5D%5Bc%5D%5B1%5D%5Ba%5D%5B0%5D%5Bname%5D=id&q%5Bg%5D%5B0%5D%5Bc%5D%5B1%5D%5Bp%5D=lt&q%5Bg%5D%5B0%5D%5Bc%5D%5B1%5D%5Bv%5D%5B0%5D%5Bvalue%5D=54&q%5Bg%5D%5B0%5D%5Bc%5D%5B1714074642220%5D%5Ba%5D%5B0%5D%5Bname%5D=posts_title&q%5Bg%5D%5B0%5D%5Bc%5D%5B1714074642220%5D%5Bp%5D=start&q%5Bg%5D%5B0%5D%5Bc%5D%5B1714074642220%5D%5Bv%5D%5B0%5D%5Bvalue%5D=a&q%5Bg%5D%5B0%5D%5Bg%5D%5B0%5D%5Bm%5D=or&q%5Bg%5D%5B0%5D%5Bg%5D%5B0%5D%5Bc%5D%5B0%5D%5Ba%5D%5B0%5D%5Bname%5D=email&q%5Bg%5D%5B0%5D%5Bg%5D%5B0%5D%5Bc%5D%5B0%5D%5Bp%5D=cont&q%5Bg%5D%5B0%5D%5Bg%5D%5B0%5D%5Bc%5D%5B0%5D%5Bv%5D%5B0%5D%5Bvalue%5D=ojk&commit=Search'
# Rack::Utils.parse_nested_query(str)

require_relative 'parser/simple'
require_relative 'parser/advanced'
require_relative 'nodes/group'
module Arrysack
  module Parser
    G_KEY = 'g' # group
    C_KEY = 'c' # conditions
    A_KEY = 'a' # query attribute
    V_KEY = 'v' # query value
    M_KEY = 'm' # combinator
    P_KEY = 'p' # predicate
    S_KEY = 's' # sorting
    ADVANCED_KEYS = [G_KEY, C_KEY, A_KEY, V_KEY, P_KEY].freeze
    SHARED_KEYS = [M_KEY, S_KEY].freeze

    extend self

    def parse(params, schema)
      advanced_params = extract_advanced_params(params)
      basic_params = extract_basic_params(params)

      combinator_name = params.delete(M_KEY) || params.delete(M_KEY.to_sym)
      root_group = Nodes::Group.new(combinator: combinator_name)

      Advanced.new(advanced_params, schema, root_group).parse
      Simple.new(basic_params, schema, root_group).parse

      root_group
    end

    private

    def extract_basic_params(params)
      params.each_with_object({}) do |(k, v), o|
        o[k.to_s] = v unless ADVANCED_KEYS.include?(k.to_s)
      end
    end

    def extract_advanced_params(params)
      params.each_with_object({}) do |(k, v), o|
        o[k.to_s] = v if (ADVANCED_KEYS + SHARED_KEYS).include?(k.to_s)
      end
    end
  end
end
