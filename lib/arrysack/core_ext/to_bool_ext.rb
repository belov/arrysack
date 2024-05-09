# frozen_string_literal: true

module Arrysack
  module CoreExt
    module ToBoolExt
      FALSE_VALUES = [false, nil, 0].to_set
      STR_FALSE_VALUES = ['', '0', 'f', 'false', 'off'].to_set

      refine ::Object do
        def to_bool
          return !STR_FALSE_VALUES.include?(downcase) if is_a?(String)

          FALSE_VALUES.include?(self)
        end
      end
    end
  end
end
