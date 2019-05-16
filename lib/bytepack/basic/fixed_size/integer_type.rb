module Bytepack
  class IntegerType < FixedSize
    # Reserved class
    
    class << self
    end
    
  end
end

require 'bytepack/basic/fixed_size/integer_type/byte'
require 'bytepack/basic/fixed_size/integer_type/u_byte'
require 'bytepack/basic/fixed_size/integer_type/short'
require 'bytepack/basic/fixed_size/integer_type/u_short'
require 'bytepack/basic/fixed_size/integer_type/integer'
require 'bytepack/basic/fixed_size/integer_type/u_integer'
require 'bytepack/basic/fixed_size/integer_type/long'
require 'bytepack/basic/fixed_size/integer_type/u_long'