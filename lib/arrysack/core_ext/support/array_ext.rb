# frozen_string_literal: true

module Arrysack
  module CoreExt
    module Support
      module ArrayExt
        refine ::Array.singleton_class do
          def wrap(object)
            if object.nil?
              []
            elsif object.respond_to?(:to_ary)
              object.to_ary || [object]
            else
              [object]
            end
          end
        end
      end
    end
  end
end
