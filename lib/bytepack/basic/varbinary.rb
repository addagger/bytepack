module Bytepack
  class Varbinary < Basic
    DIRECTIVE = 'a'
    NULL_INDICATOR = -1 # NULL indicator for object type serializations
    LENGTH_TYPE = AnyType

    class << self
      def pack(val)
        if val.nil?
          AnyType.pack(self::NULL_INDICATOR)
        else
          val = convert_input(val)
          self::LENGTH_TYPE.pack(val.bytesize) + val
        end
      end
      
      def unpack(bytes, offset = 0)
        length, offset = *self::LENGTH_TYPE.unpack(bytes, offset)
        case length
        when self::NULL_INDICATOR then [nil, offset]
        when 0 then ["", offset]
        else
          offset, format = *preprocess(bytes, offset, self::DIRECTIVE, length)
          [bytes.unpack1(format), offset]
        end
      end
        
      def convert_input(val)
        val.to_s.encode("ascii-8bit")
      end
    end
    
  end
end