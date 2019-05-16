module Bytepack
  class FixedSize < Basic
    
    class << self
      def pack(val)
        val ||= self::NULL_INDICATOR
        [val].pack(self::DIRECTIVE)
      end
  
      def unpack(bytes, offset = 0)
        offset, format = *preprocess(bytes, offset, self::DIRECTIVE, self::LENGTH)
        unpacked = bytes.unpack1(format)
        if unpacked == self::NULL_INDICATOR
          [nil, offset]
        else
          [unpacked, offset]
        end
      end
    end
    
  end
end

require 'bytepack/basic/fixed_size/integer_type'
require 'bytepack/basic/fixed_size/float'
require 'bytepack/basic/fixed_size/timestamp' # Date
require 'bytepack/basic/fixed_size/decimal'
require 'bytepack/basic/fixed_size/null'