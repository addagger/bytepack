module Bytepack
  class Array < Complex
    LENGTH_TYPE = AnyType
    
    class << self
      def pack(array = [])
        elements_count = array.size
        self::LENGTH_TYPE.pack(elements_count) + array.map {|val| AnyType.pack(val)}.join
      end
    
      def unpack(bytes, offset = 0)
        elements_count, offset = *self::LENGTH_TYPE.unpack(bytes, offset)
        elements = elements_count.times.map do
          element, offset = *AnyType.unpack(bytes, offset)
          element
        end
        [elements, offset]
      end
    end
    
  end
end