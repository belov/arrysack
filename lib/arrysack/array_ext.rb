# frozen_string_literal: true

require_relative 'query'
module Arrysack
  module ArrayExt
    def arrysack(params, schema = {})
      Arrysack::Query.new(params, schema).on(self)
    end
  end
end
