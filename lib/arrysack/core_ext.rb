# frozen_string_literal: true

require_relative 'core_ext/to_bool_ext'
require_relative 'core_ext/support/array_ext'
require_relative 'core_ext/support/object/blank'
module Arrysack
  module CoreExt
    include ToBoolExt
    unless Object.const_defined?('ActiveSupport')
      include Support::ArrayExt
      include Support::Object::Blank
    end
  end
end
